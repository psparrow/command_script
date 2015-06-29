module CommandScript
  Commands = CommandScript::CommandSet.new

  module DSL
    def command(name, defaults = {}, &block)
      # TODO check if command already exists

      klass = CommandScript::Command.clone
      klass.send(:define_method, :execute) { instance_eval &block }
      klass.send(:define_method, :defaults) { defaults }

      Commands.register(name, klass)
    end

    def profile(*args, &block)
      p = CommandScript::Profile.new(*args, &block)
      p.start
    end
  end
end
