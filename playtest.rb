#!/usr/bin/env ruby

def overwrite_plist
  puts "Overwriting original plist on system"
  puts `cp settymon/originals/divvy/com.mizage.direct.Divvy.plist ~/Library/Preferences`
end

def read_plist
  puts "Reading system plist to clear cache"
  puts `defaults read ~/Library/Preferences/com.mizage.direct.Divvy.plist`
end

def get_xml
  puts "Converting system plist to XML"
  puts `plutil -convert xml1 -o - ~/Library/Preferences/com.mizage.direct.Divvy.plist`
end

def app_pid(app_name)
  puts `ps aux | grep Applications`.split("\n").select { |l| l.include? "#{app_name}.app"}.first.match(/\d+\s/)[0]
end

overwrite_plist
read_plist
get_xml
