require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#each' do
  subject { offset.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:offset)     { Relation::Operation::Offset.new(order, 1)                   }
  let(:yields)     { []                                                          }

  it { should equal(offset) }

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 2 ], [ 3 ] ])
  end
end
