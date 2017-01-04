require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :osfamily => 'Ubuntu',
    :operatingsystemmajrelease => '14.04',
    :release_version => '1.4.0'
  }
end

if Puppet.version.to_f >= 4.5
  RSpec.configure do |c|
    c.before :each do
      Puppet.settings[:strict] = :error
    end
  end
end

begin
  require 'spec_helper_local'
rescue LoadError
end