require "test_helper"

class ImportProductionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should create PowerInverterProduction" do
    test_csv_path = Rails.root.join("test", "fixtures", "files", "inverter_production_test.csv")
    assert File.exist?(test_csv_path), "The test CSV file was not found."
    uploaded_file = Rack::Test::UploadedFile.new(test_csv_path, "text/csv")

    assert_difference("PowerInverterProduction.count", 2) do
      post import_path, params: { production_file: uploaded_file }
    end

    assert_redirected_to root_path
    assert_equal "Successfully imported the CSV file.", flash[:notice]
  end
end
