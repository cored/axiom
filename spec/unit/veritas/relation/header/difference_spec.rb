require File.expand_path('../../../../../spec_helper', __FILE__)

[ :difference, :- ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    subject { header.send(method, other) }

    let(:attribute1) { [ :id,   Integer ]                   }
    let(:attribute2) { [ :name, String  ]                   }
    let(:header)     { Relation::Header.new([ attribute1 ]) }
    let(:other)      { Relation::Header.new([ attribute2 ]) }

    it { should be_kind_of(Relation::Header) }

    it { should == [ attribute1 ] }
  end
end
