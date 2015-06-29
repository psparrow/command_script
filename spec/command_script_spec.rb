require_relative './spec_helper'

describe CommandScript do
  let(:dummy_command) {
    CommandScript::Command.new(message: 'toes') do
      "message: #{message}"
    end
  }

  it 'has a command set' do
    expect(CommandScript::Commands).to be_a(CommandScript::CommandSet)
  end

  describe '.command' do
    include CommandScript::DSL

    before do
      command :send, message: '-blank-' do
        "message: #{message}"
      end
    end

    it 'supports defaults' do
      send = CommandScript::Commands[:send].new
      expect(send.message).to eq('-blank-')
    end

    it 'behaves like a Command' do
      send = CommandScript::Commands[:send].new(message: 'toes')
      expect(send.execute).to eq(dummy_command.execute)
    end
  end
end
