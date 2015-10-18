require 'spec_helper'
describe 'yuicompressor' do

  context 'with defaults for all parameters' do
    it { should contain_class('yuicompressor') }
  end
end
