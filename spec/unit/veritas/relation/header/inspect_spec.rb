require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#inspect' do
  subject { header.inspect }

  let(:attribute) { [ :id, Integer ]                    }
  let(:header)    { Relation::Header.new([ attribute ]) }

  it { should be_kind_of(String) }

  it { should == '[<Attribute::Integer name: id>]' }
end
