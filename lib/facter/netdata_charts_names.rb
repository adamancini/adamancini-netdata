require 'json'
Facter.add(:netdata_charts_names) do
  setcode do
    charts_json = Facter::Core::Execution.exec('curl -X GET localhost:19999/api/v1/charts | jq \'.charts[].id\'')
    charts_hash = JSON.parse(charts_json)
  end
end