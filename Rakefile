require 'rake'

@home_dir = `echo $HOME`.strip
@exclusions = %w(rake fish readme.md iterm bin)
@bashfiles = %w(bash_profile bash_prompt bash_scripts exports functions inputrc)

namespace :install do
  task :default, [:force] do |t, args|
    if args[:force]
      puts '*****************************'
      puts 'Overwriting existing symlinks'
      puts '*****************************'
    end

    symlink_files(args)
    symlink_bin
  end

  def symlink_bin
    if File.exist? '/Users/jonan/bin'
      puts "Not symlinking #{@home_dir}/bin, you already have one."
    else
      puts "Symlinking #{@home_dir}/dotfiles/bin to #{@home_dir}/bin"
      `ln -s #{@home_dir}/dotfiles/bin #{@home_dir}/bin`
    end
  end

  def symlink_files(args = {})
    Dir['*'].each do |filename|
      pwd = `pwd`.strip


      if exclude? filename
        puts "Skipping excluded file: #{pwd}/#{filename}"
      elsif link_exists?(filename) && !args[:force]
        puts "Skipping existing file: #{@home_dir}/.#{filename}"
      else
        puts "Symlinking #{pwd}/#{filename} to #{@home_dir}/.#{filename}"
        `ln -s #{'-f ' if args[:force]}#{pwd}/#{filename} #{@home_dir}/.#{filename}`
      end
    end
  end

  desc "Install fish prompt instead of bash."
  task :fish do
    @exclusions += @bashfiles
    symlink_files
    symlink_bin
    puts "Symlinking fish/config.fish to #{@home_dir}/.config/fish/config.fish (overwriting config.fish)"
    `ln -sf #{@home_dir}/dotfiles/fish/config.fish #{@home_dir}/.config/fish/config.fish`
  end

  desc "Force symlinking of dotfiles to home directory."
  task :force do
    Rake::Task["install:default"].invoke(true)
  end
end

def exclude?(filename)
  @exclusions.include? filename.downcase
end

def link_exists?(filename)
  File.exists? File.join(`echo $HOME`.strip, ".#{filename}")
end

desc "Symlink dotfiles to home directory"
task :install => ["install:default"]
