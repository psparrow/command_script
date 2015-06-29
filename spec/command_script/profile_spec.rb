require_relative '../spec_helper'

describe CommandScript::Profile do
  let(:commands) { [double('command', execute: true)] }

  before do
    allow(subject).to receive(:commands) { commands }
  end

  describe '#run' do
    it 'executes each command' do
      expect(subject.commands.first).to receive(:execute)
      subject.run
    end

    it 'returns true' do
      expect(subject.run).to eq(true)
    end
  end

  describe '#start' do
    subject { described_class.new(seconds: 0.1) }

    it 'repeats every X seconds' do
      expect(subject).to receive(:run).at_most(3).times

      thread = Thread.new do
        subject.start
      end

      sleep(0.3)
      thread.kill
    end
  end
end
