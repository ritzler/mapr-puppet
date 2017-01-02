require 'spec_helper'
describe 'selinux' do
  context 'with default values for all parameters' do
    it { should contain_class('selinux') }
  end
end
