require "test_helper"

class PowerInverterProductionTest < ActiveSupport::TestCase
  test "should not save power_inverter_production without identifier" do
    power_inverter_production = PowerInverterProduction.new(
      datetime: DateTime.strptime('10/07/25 06:00', '%d/%m/%y %H:%M'),
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
      datetime: DateTime.strptime('10/07/25 06:00', '%d/%m/%y %H:%M')
      )
    assert_not power_inverter_production.save
  end
end
