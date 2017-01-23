require 'json'
Facter.add(:netdata_charts_names) do
  setcode do
    if File.exists? '/etc/netdata'
      charts_json = Facter::Core::Execution.exec('/usr/bin/curl --silent -X GET http://localhost:19999/api/v1/charts | tr -d \'\\040\\011\\012\\015\' | jq \'. | { hostname: .hostname, charts: [.charts[] | .id] }\'')
      charts_hash = JSON.parse(charts_json)
    end
  end
end