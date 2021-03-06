# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::LessThan, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should be(Function::Predicate::GreaterThan) }
end
