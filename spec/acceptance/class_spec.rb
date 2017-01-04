require 'spec_helper_acceptance'

describe '::netdata class' do
  context 'default parameters' do
    let(:manifest) {
      <<-EOS
      class { 'netdata': }
      EOS
    }

    # apply twice and check for idempotency
    it 'should apply with no errors' do
      apply_manifest(manifest, :catch_failures => true)
    end

    it 'should apply a second time with no changes' do
      @result = apply_manifest(manifest)
      expect(@result.exit_code).to be_zero
    end

    describe port('19999') do
      it { is_expected.to be_listening }
    end
  end
end