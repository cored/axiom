# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Comparable, '#asc' do
  subject { object.asc }

  let(:described_class) { ComparableSpecs::Object }
  let(:object)          { described_class.new     }

  it { should be_instance_of(Relation::Operation::Sorted::Ascending) }
end
