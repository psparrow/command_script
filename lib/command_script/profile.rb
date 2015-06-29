module CommandScript
  class Profile
    attr_reader :commands, :seconds, :times, :variables

    def initialize(args = {}, &block)
      @commands = []
      @variables = {}
      @seconds = args[:seconds] || false
      @times = args[:times] || false

      instance_eval(&block) if block
    end

    def method_missing(m, *args, &block)
      c =  CommandScript::Commands[m].new(*args)
      c.profile = self
      @commands << c
    end

    def set(var, value)
      @variables[var] = value
    end

    def sub_vars(string)
      variables.each do |key, value|
        if string.include? "{#{key}}"
          string.gsub!("{#{key}}", value.to_s)
        end
      end
      string
    end

    def run
      commands.each do |command|
        command.execute
      end

      true
    end

    def start
      current = 0

      loop do
        current += 1

        run

        break if times == current
        break unless times || seconds
        sleep seconds if seconds
      end
    end
  end
end
