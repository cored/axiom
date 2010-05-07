require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#rename' do
  subject { directions.rename(aliases) }

  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }
  let(:aliases)    { { :id => :other_id }                                        }

  it { should_not be_equal(directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ Attribute::Integer.new(:other_id) ] }
end
