require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Expression::ClassMethods#eval' do
  subject { klass.eval }

  let(:klass) do
    Class.new do
      include Logic::Expression

      def self.name
        'AnonymousClass'
      end
    end
  end

  specify { method(:subject).should raise_error(NotImplementedError, 'AnonymousClass.eval must be implemented') }
end
