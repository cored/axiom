require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Exclusion::OneRightOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Logic::Predicate::Exclusion::OneRightOperand }
  let(:attribute) { Attribute::Integer.new(:id)                             }
  let(:predicate) { attribute.exclude(operand)                              }
  let(:object)    { klass.new(predicate)                                    }

  before do
    predicate.should be_kind_of(Veritas::Logic::Predicate::Exclusion)
  end

  context 'when the operand contains a one entry Enumerable' do
    let(:operand) { [ 1 ] }

    it { should eql(attribute.ne(1)) }
  end

  context 'when the operand contains a one entry inclusive Range' do
    let(:operand) { 1..1 }

    it { should eql(attribute.ne(1)) }
  end

  context 'when the operand contains a one entry exclusive Range' do
    let(:operand) { 1...2 }

    it { should eql(attribute.ne(1)) }
  end

  context 'when the operand contains one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1 ] }

    it { should eql(attribute.ne(1)) }
  end

  context 'when the operand contains one entry after filtering duplicate entries' do
    let(:operand) { [ 1, 1 ] }

    it { should eql(attribute.ne(1)) }
  end
end