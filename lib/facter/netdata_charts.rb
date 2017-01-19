require 'json'
Facter.add(:netdata_charts) do
  setcode do
    charts_hash = {}
    charts_hash = Facter::Core::Execution.exec('/usr/bin/curl -X GET http://localhost:19999/api/v1/charts | tr -d \'\\040\\011\\012\\015\'')
  end
end