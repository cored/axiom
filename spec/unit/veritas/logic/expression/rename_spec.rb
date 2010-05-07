require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#rename' do
  subject { expression.rename({}) }

  let(:expression) { ExpressionSpecs::Object.new }

  it 'returns self' do
    should equal(expression)
  end
end
