require 'spec_helper'
describe 'mapr' do
  context 'with default values for all parameters' do
    it { should contain_class('mapr') }
  end
end
