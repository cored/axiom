require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#call' do
  subject { negation.call(tuple) }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:operand)  { header[:id].eq(1)                          }
  let(:negation) { Logic::Connective::Negation.new(operand)   }

  context 'with a tuple that matches' do
    let(:tuple) { Tuple.new(header, [ 2 ]) }

    it { should be(true) }
  end

  context 'with a tuple that does not match' do
    let(:tuple) { Tuple.new(header, [ 1 ]) }

    it { should be(false) }
  end
end
