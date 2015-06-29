module CommandScript
  class Command
    attr_accessor :profile
    attr_reader :params

    def initialize(args = {}, &block)
      @params = defaults.merge(args)

      if block
        @block = block.to_proc
      else
        @block = nil
      end

      define_methods_for_params
    end

    def define_methods_for_params
      params.each do |key, value|
        singleton_class.send(:define_method, key) { value }
      end
    end

    def defaults
      {}
    end

    def execute
      self.instance_eval(&@block) if @block
    end
  end
end
