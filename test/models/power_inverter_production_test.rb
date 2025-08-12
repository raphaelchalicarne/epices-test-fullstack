require "test_helper"

class PowerInverterProductionTest < ActiveSupport::TestCase
  test "should not save power_inverter_production without identifier" do
    power_inverter_production = PowerInverterProduction.new
    assert_not power_inverter_production.save
  end
end
