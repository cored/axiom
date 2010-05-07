require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order.new' do
  subject { Relation::Operation::Order.new(relation, directions) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with all attributes specified in the directions' do
    let(:directions) { [ relation[:id] ] }

    it 'sets the relation' do
      subject.relation.should equal(relation)
    end

    it 'sets the directions' do
      subject.directions.should == [ relation[:id].asc ]
    end
  end

  context 'without all attributes specified in the directions' do
    let(:directions) { [] }

    specify { method(:subject).should raise_error(ArgumentError, 'directions must include every attribute in the header') }
  end
end
