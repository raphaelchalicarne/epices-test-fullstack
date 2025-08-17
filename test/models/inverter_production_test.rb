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
end
