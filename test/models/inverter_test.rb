require "test_helper"

class InverterTest < ActiveSupport::TestCase
  test "#self.identifiers should return an array of the distinct inverter identifiers" do
    assert_equal Inverter.identifiers.to_set, [ 1, 2 ].to_set
  end
end
