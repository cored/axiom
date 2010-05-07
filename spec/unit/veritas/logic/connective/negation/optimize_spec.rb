require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#optimize' do
  subject { negation.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'operand is a predicate' do
    let(:operand)  { attribute.gt(1)                          }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should eql(attribute.lte(1)) }
  end

  context 'operand is a negated predicate' do
    let(:predicate) { attribute.gt(1)                            }
    let(:operand)   { Logic::Connective::Negation.new(predicate) }
    let(:negation)  { Logic::Connective::Negation.new(operand)   }

    it { should eql(predicate) }
  end

  context 'operand is a true proposition' do
    let(:operand)  { Logic::Proposition::True.instance        }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'operand is a false proposition' do
    let(:operand)  { Logic::Proposition::False.instance       }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should equal(Logic::Proposition::True.instance) }
  end
end
