require 'spec_helper_acceptance'

describe 'yuicompressor class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors based on the example' do
      pp = <<-EOS

        package { 'java-1.8.0-openjdk':
          ensure => 'installed',
        } ->

        class { 'yuicompressor':
        }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it 'yui --version should give us the default version (2.4.8)' do
       shell("/usr/local/bin/yui --version") do |r|
         expect(r.stderr).to match(/2\.4\.8/)
       end
     end

  end
end
