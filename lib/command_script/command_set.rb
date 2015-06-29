require 'forwardable'

module CommandScript
  class CommandSet
    extend Forwardable
    attr_reader :commands
    def_delegators :commands, :store, :[]

    def initialize
      @commands = {}
    end

    alias_method :register, :store
  end
end
