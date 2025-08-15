require "test_helper"

class PowerInverterProductionTest < ActiveSupport::TestCase
  test "should not save power_inverter_production without identifier" do
    power_inverter_production = PowerInverterProduction.new(
      datetime: DateTime.strptime("10/07/25 06:00", "%d/%m/%y %H:%M"),
      energy: 343
      )
    assert_not power_inverter_production.save
  end

  test "should not save power_inverter_production without datetime" do
    power_inverter_production = PowerInverterProduction.new(
      identifier: 1,
      energy: 343
      )
    assert_not power_inverter_production.save
  end

  test "should not save power_inverter_production without energy" do
    power_inverter_production = PowerInverterProduction.new(
      identifier: 1,
      datetime: DateTime.strptime("10/07/25 06:00", "%d/%m/%y %H:%M")
      )
    assert_not power_inverter_production.save
  end

  test "should save power_inverter_production with identifier, datetime and energy attributes" do
    assert power_inverter_productions(:one_july_10_06).save
  end

  test "#self.identifiers should return an array of the distinct identifiers" do
    assert_equal PowerInverterProduction.identifiers.to_set, [ 1, 2 ].to_set
  end

  test "#self.production" do
    expected_production = {
      DateTime.civil(2025, 7, 10, 6, 0, 0, 0).in_time_zone => 343,
      DateTime.civil(2025, 7, 10, 7, 0, 0, 0).in_time_zone => 2174
    }
    assert_equal PowerInverterProduction.production(1, Date.civil(2025, 7, 10)), expected_production
  end
end
