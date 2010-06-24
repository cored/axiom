require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#inspect' do
  subject { expression.inspect }

  let(:expression) { ExpressionSpecs::Object.new }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#inspect must be implemented') }
end
