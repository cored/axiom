require 'spec_helper'

describe 'Veritas::Algebra::Intersection#each' do
  subject { intersection.each { |tuple| yields << tuple } }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }
  let(:yields) { []                              }

  context 'with relations having similar bodies' do
    let(:intersection) { Algebra::Intersection.new(left, left.dup) }

    it { should equal(intersection) }

    it 'yields the intersection' do
      expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ] ])
    end
  end

  context 'with relations having different bodies' do
    let(:right)        { Relation.new(header, [ [ 2 ] ])        }
    let(:intersection) { Algebra::Intersection.new(left, right) }

    it { should equal(intersection) }

    it 'yields the intersection' do
      expect { subject }.to_not change { yields.dup }
    end
  end
end
