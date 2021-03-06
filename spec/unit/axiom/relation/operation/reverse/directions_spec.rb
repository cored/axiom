# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Reverse, '#directions' do
  subject { object.directions }

  let(:relation) { Relation.new([[:id, Integer]], LazyEnumerable.new) }
  let(:object)   { described_class.new(sorted)                        }
  let(:sorted)   { relation.sort_by { |r| r.id }                      }

  it_should_behave_like 'an idempotent method'

  it 'reverses the directions' do
    should eql(sorted.directions.reverse)
  end
end
