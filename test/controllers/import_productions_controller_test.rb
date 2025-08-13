class ImportProductionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should create PowerInverterProduction" do
    assert_difference("PowerInverterProduction.count") do
      # Mocking an input CSV file
      header = "identifier,datetime,energy"
      row2 = "1,11/07/25 06:00,194"
      row3 = "2,11/07/25 06:00,458"
      rows = [ header, row2, row3 ]
      test_csv_file = CSV.open("tmp/test.csv", "w") do |csv|
        rows.each do |row|
          csv << row.split(",")
        end
      end
      post import_url, params: { production_file: test_csv_file }
    end
  end
end
