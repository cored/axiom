require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#rename' do
  subject { directions.rename(aliases) }

  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:header)     { Relation::Header.new([ attribute ])                         }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }
  let(:aliases)    { Algebra::Rename::Aliases.coerce(header, :id => :other_id)   }

  it { should_not equal(directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ Attribute::Integer.new(:other_id) ] }
end
