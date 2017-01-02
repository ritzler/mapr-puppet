require 'spec_helper'
describe 'etcprofile' do
  context 'with default values for all parameters' do
    it { should contain_class('etcprofile') }
  end
end
