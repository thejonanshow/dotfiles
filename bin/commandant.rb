module Commandant
  class Prompt
    attr_reader :commands

    def initialize(exit = true)
      @commands = {}

      insert_command 'x', 'E(x)it' do
        puts "Exiting."
      end if exit
    end

    def add_command(letter, description, &block)
      raise CommandError.new "You can't use 'x' for a command." if letter.downcase == 'x'
      insert_command(letter, description, &block)
    end

    def run
      allowed = []
      command_descriptions = ''

      self.commands.each do |letter, command|
        allowed << letter
        command_descriptions += "#{letter}: #{command[:description]}\n"
      end

      selected = ''
      until allowed.include? selected
        puts "Please select one of the following options:"
        puts command_descriptions
        print ">"
        selected = gets.chomp.downcase
      end

      @commands[selected][:block].call
    end

    private

    def insert_command(letter, description, &block)
      @commands[letter] = { description: description, block: block }
    end
  end

  class CommandError < ArgumentError; end
end
