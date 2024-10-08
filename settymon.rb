#!/usr/bin/env ruby

require "fileutils"
require "digest"
require "optparse"

# Default DEBUG mode to true, but allow overriding via CLI
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: script.rb [options]"
  opts.on("-d", "--debug", "Enable/Disable debug mode") do |v|
    options[:debug] = v.nil? ? false : !v
  end
  opts.on("-q", "--quiet", "Enable quiet mode (no debug output)") do
    options[:quiet] = true
  end
end.parse!

DEBUG = options[:debug].nil? ? false : options[:debug]
QUIET = options[:quiet] || false
DOTFILES_DIR = File.expand_path("~/src/dotfiles")
SETTINGS_DIR = File.join(DOTFILES_DIR, "settymon")
TMP_DIR = File.join(SETTINGS_DIR, "tmp")
ORIGINALS_DIR = File.join(SETTINGS_DIR, "originals")
LOCALS_DIR = File.join(SETTINGS_DIR, "plists")
GROUP_CONTAINERS_DIR = File.expand_path("~/Library/Group Containers")
PLIST_PATHS = {}

# If DEBUG is enabled, redefine FileUtils as a no-op, providing feedback on what would have happened
if DEBUG
  Object.send(:remove_const, :FileUtils)

  module FileUtils
    def self.method_missing(method, *args, &block)
      puts "DEBUG: #{method} #{args.join(', ')}" unless QUIET
    end
  end
end

FileUtils.mkdir_p([SETTINGS_DIR, ORIGINALS_DIR, LOCALS_DIR, TMP_DIR])

# Colorize method with full ANSI color options
def colorize(text, color)
  color_code = case color
               when :black then 30
               when :red then 31
               when :green then 32
               when :yellow then 33
               when :blue then 34
               when :magenta then 35
               when :cyan then 36
               when :light_gray then 37
               when :dark_gray then 90
               when :light_red then 91
               when :light_green then 92
               when :light_yellow then 93
               when :light_blue then 94
               when :light_magenta then 95
               when :light_cyan then 96
               when :white then 97
               else 0 # Default to no color
               end
  "\e[#{color_code}m#{text}\e[0m"
end

def log(message, color = :default)
  puts colorize(message, color) unless QUIET
end

# Backup the original plist if it exists, adding a timestamp if necessary
def backup_original_plist(app_name, host_plist)
  app_original_dir = File.join(ORIGINALS_DIR, app_name)
  FileUtils.mkdir_p(app_original_dir)

  existing_files = Dir.glob("#{app_original_dir}/*.plist")
  if existing_files.empty?
    original_plist = File.join(app_original_dir, File.basename(host_plist))
  else
    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
    original_plist = File.join(app_original_dir, "#{File.basename(host_plist, '.plist')}_#{timestamp}.plist")
  end

  log("Backing up host plist for #{app_name} to #{original_plist}...", :green)
  FileUtils.cp(host_plist, original_plist)
end

# Copy the plist to the local directory (for symlink creation)
def copy_plist_to_local(app_name, host_plist, local_plist)
  log("Copying host plist for #{app_name} to #{local_plist}...", :green)
  FileUtils.cp(host_plist, local_plist)
end

# Create symlink in a temporary location and then atomically move it into place
def create_atomic_symlink(app_name, target, symlink)
  temp_symlink = File.join(TMP_DIR, "#{File.basename(symlink)}.tmp")

  log("Creating temporary symlink for #{app_name}: #{temp_symlink} -> #{target}", :green)
  FileUtils.ln_sf(target, temp_symlink)

  log("Atomically moving symlink into place for #{app_name}: #{symlink}", :green)
  FileUtils.mv(temp_symlink, symlink)
end

# Memoized method to get cask names from the Brewfile
def brewfile_app_names
  @brewfile_app_names ||= File.readlines("#{DOTFILES_DIR}/brewfile").grep(/^cask/).map { |line| line.split.last.strip.delete("'") }
end

# Memoized method to get installed apps
def get_installed_apps
  @installed_apps ||= `brew list --cask`.split
end

# Memoized method to get brew info for all apps
def get_brew_info(apps)
  @brew_info ||= `brew info --cask #{apps.join(' ')}`
end

# Process apps to extract artifacts and find plist paths
def process_apps(bulk_brew_info, apps)
  apps_with_artifacts = []
  apps_without_artifacts = []
  apps_with_plists = {}

  apps.each do |app_name|
    relevant_lines = bulk_brew_info[/==> #{app_name}.+?(?==> Analytics)/m]
    artifacts = if relevant_lines&.include?("==> Artifacts")
                  relevant_lines.split("==> Artifacts").last.split("==>").first.lines
                else
                  ["none found"]
                end

    app_artifacts = artifacts.select { |art| art.include?("(App)") }.map { |art| art.split(".app").first.strip + ".app" }

    if app_artifacts.empty?
      apps_without_artifacts << app_name
    else
      apps_with_artifacts << app_name
      app_artifacts.each do |artifact|
        app_path = "/Applications/#{artifact}"
        if File.directory?(app_path)
          # Get the bundle identifier using mdls
          bundle_id = `mdls -name kMDItemCFBundleIdentifier "#{app_path}" 2>/dev/null`.split(" = ").last&.strip&.gsub('"', '')
          if bundle_id
            host_plist = File.expand_path("~/Library/Preferences/#{bundle_id}.plist")
            local_plist = File.join(LOCALS_DIR, "#{bundle_id}.plist")
            # Only add to apps_with_plists if the host plist exists
            if File.exist?(host_plist) || File.exist?(local_plist)
              apps_with_plists[app_name] = { host: host_plist, local: local_plist, bundle_id: bundle_id }
              PLIST_PATHS[app_name] = { host: host_plist, local: local_plist, bundle_id: bundle_id }
            end
          end
        end
      end
    end
  end

  [apps_with_artifacts, apps_without_artifacts, apps_with_plists]
end

# Handle backing up and managing plists for an application
def handle_app_plist(app_name, plist_paths)
  host_plist = plist_paths[:host]
  local_plist = plist_paths[:local]

  host_plist_exists = File.exist?(host_plist)
  local_plist_exists = File.exist?(local_plist)

  if host_plist_exists && local_plist_exists
    log("#{app_name} has a host plist and a local plist.", :blue)
    backup_original_plist(app_name, host_plist)
    create_atomic_symlink(app_name, local_plist, host_plist)

  elsif host_plist_exists
    log("#{app_name} has a host plist, but no local plist.", :cyan)
    backup_original_plist(app_name, host_plist)
    copy_plist_to_local(app_name, host_plist, local_plist)
    create_atomic_symlink(app_name, local_plist, host_plist)

  elsif local_plist_exists
    log("#{app_name} has no host plist, restoring from local backup.", :yellow)
    create_atomic_symlink(app_name, local_plist, host_plist)

  else
    log("Warning: No plist found for #{app_name}, and no local backup available.", :red)
  end
end

# Check for group container plists
def check_group_containers(apps_with_artifacts)
  apps_with_group_containers = []

  apps_with_artifacts.each do |app_name|
    begin
      Dir.glob("#{GROUP_CONTAINERS_DIR}/**/*.plist").each do |plist|
        if plist.include?(app_name) || plist.include?(PLIST_PATHS.dig(app_name, :bundle_id))
          apps_with_group_containers << app_name
          break
        end
      end
    rescue Errno::EPERM => e
      log("Skipping directory due to permission error: #{e.message}", :red)
      break # Stop checking after the first permission error
    end
  end

  apps_with_group_containers.uniq
end

# Prettier output with bullet points and spacing
def output_results(apps_with_artifacts, apps_without_artifacts, apps_with_plists, apps_with_group_containers)
  log('Apps with artifacts:', :green)
  apps_with_artifacts.each { |app| log("  - #{app}") }

  log('Apps without artifacts:', :yellow)
  apps_without_artifacts.each { |app| log("  - #{app}") }

  log('Apps with plist setting files:', :cyan)
  apps_with_plists.each { |app, paths| log("  - #{app}: #{paths[:host]}") }

  log('Apps with group container plist files:', :blue)
  if apps_with_group_containers.any?
    apps_with_group_containers.each { |app| log("  - #{app}") }
  else
    log("  None found.")
  end

  puts
end

# Main logic of the script
def main
  log("Running in DEBUG mode", :yellow) if DEBUG

  # Fetch apps and brew info
  apps = get_installed_apps
  bulk_brew_info = get_brew_info(apps)

  # Process app info
  apps_with_artifacts, apps_without_artifacts, apps_with_plists = process_apps(bulk_brew_info, apps)

  # Handle plist management
  apps_with_plists.each do |app_name, plist_paths|
    log("--- #{app_name}", :light_blue)
    handle_app_plist(app_name, plist_paths)
  end

  # Check group containers
  apps_with_group_containers = check_group_containers(apps_with_artifacts)

  # Output results
  output_results(apps_with_artifacts, apps_without_artifacts, apps_with_plists, apps_with_group_containers)
end

# Run the main logic
main

