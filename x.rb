require 'pry'

module CommandScript
  class Profile
    def initialize(args = {}, &block)
      @repeat = args[:repeat] || 0
      @variables = {}
      @commands = block.to_proc
    end

    def run
      @commands.call
    end
  end

  class Command
    def initialize(args = {}, &block)
      args.each do |name, value|
        self.class.send(:define_method, name) { value }
      end
      @block = block
    end

    def execute
      self.instance_eval &@block
    end
  end
end

collect = CommandScript::Command.new(testing: "TEST") do
  puts testing
end



collect.execute

commands = []

module CommandScript::Commands
end

def command(name, args = {}, &block)
  puts "creating command #{name}"
  CommandScript::Commands.send(:define_method, name) do
    c = CommandScript::Command.new(args, &block)
    commands << c
  end
end

command :sendx, message: nil do
  puts "Sending #{message}"
end


sendx message: "BLAH"
