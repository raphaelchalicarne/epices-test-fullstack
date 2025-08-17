require "test_helper"

class InverterTest < ActiveSupport::TestCase
  test "#self.identifiers should return an array of the distinct inverter identifiers" do
    assert_equal Inverter.identifiers.to_set, [ 1, 2 ].to_set
  end

  test "#self.total_hourly_production should return the hourly energy production aggregated among all Inverters" do
    expected_total_hourly_production = {
      DateTime.civil(2025, 7, 10, 6, 0, 0, 0).in_time_zone => 4837,
      DateTime.civil(2025, 7, 10, 7, 0, 0, 0).in_time_zone => 2174
    }
    assert_equal Inverter.total_hourly_production(Date.civil(2025, 7, 10)), expected_total_hourly_production
  end
end
