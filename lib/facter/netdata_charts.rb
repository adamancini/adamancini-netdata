Facter.add(:netdata_charts) do
  setcode do
    Facter::Core::Execution.exec('curl -X GET http://localhost:19999/api/v1/charts')
  end
end