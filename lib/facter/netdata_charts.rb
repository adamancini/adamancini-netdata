require 'json'
Facter.add(:netdata_charts) do
  setcode do
    charts_hash = {}
    charts_hash = Facter::Core::Execution.exec('curl -X GET http://localhost:19999/api/v1/charts')
    puts JSON.pretty_generate(charts_hash, opts = nil)
  end
end