require_relative '../spec_helper'

describe CommandScript::Command do
  subject {
    described_class.new(params) do
      "foo = #{foo}, number = #{number}"
    end
  }

  let(:params) { { foo: 'bar', number: 42 } }

  it 'accepts a hash of arguments' do
    expect(subject.params).to eq(params)
  end

  it 'created readers for each param' do
    expect(subject.foo).to eq 'bar'
    expect(subject.number).to eq 42
  end

  describe '#execute' do
    it 'executes the block passed to the constructor' do
      expect(subject.execute).to eq("foo = bar, number = 42")
    end
  end
end
