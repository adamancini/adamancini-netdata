require 'spec_helper'

describe 'netdata::install' do
  
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

    it { is_expected.to compile.with_all_deps }
    end
  end
end