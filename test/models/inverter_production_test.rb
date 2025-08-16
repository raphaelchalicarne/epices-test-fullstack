require "test_helper"

class InverterProductionTest < ActiveSupport::TestCase
  test "should not save inverter_production without inverter_identifier" do
    inverter_production = InverterProduction.new(
      datetime: DateTime.strptime("10/07/25 06:00", "%d/%m/%y %H:%M"),
      energy: 343
      )
    assert_not inverter_production.save
  end

  test "should not save inverter_production without datetime" do
    inverter_production = InverterProduction.new(
      inverter_identifier: 1,
      energy: 343
      )
    assert_not inverter_production.save
  end

  test "should not save inverter_production without energy" do
    inverter_production = InverterProduction.new(
      inverter_identifier: 1,
      datetime: DateTime.strptime("10/07/25 06:00", "%d/%m/%y %H:%M")
      )
    assert_not inverter_production.save
  end

  test "should save inverter_production with inverter_identifier, datetime and energy attributes" do
    assert inverter_productions(:one_july_10_06).save
  end

  test "#self.production" do
    expected_production = {
      DateTime.civil(2025, 7, 10, 6, 0, 0, 0).in_time_zone => 343,
      DateTime.civil(2025, 7, 10, 7, 0, 0, 0).in_time_zone => 2174
    }
    assert_equal InverterProduction.production(1, Date.civil(2025, 7, 10)), expected_production
  end

    test "#self.total_production" do
    expected_production = {
      DateTime.civil(2025, 7, 10, 6, 0, 0, 0).in_time_zone => 4837,
      DateTime.civil(2025, 7, 10, 7, 0, 0, 0).in_time_zone => 2174
    }
    assert_equal InverterProduction.total_production(Date.civil(2025, 7, 10)), expected_production
  end
end
