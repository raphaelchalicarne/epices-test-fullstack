require "test_helper"

class ImportProductionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should create PowerInverterProduction" do
    test_csv_path = Rails.root.join("test", "fixtures", "files", "inverter_production.csv")
    assert File.exist?(test_csv_path), "The test CSV file was not found."
    uploaded_file = Rack::Test::UploadedFile.new(test_csv_path, "text/csv")

    assert_difference("PowerInverterProduction.count", 2) do
      post import_path, params: { production_file: uploaded_file }
    end

    assert_redirected_to root_path
    assert_equal "Successfully imported the CSV file.", flash[:notice]
  end

  test "The file sent is invalid" do
    post import_path, params: { production_file: :no_file }
    assert_response :bad_request
    assert_equal "The file sent is invalid", @response.body
  end

  test "should raise Empty CSV file" do
    empty_csv_path = Rails.root.join("test", "fixtures", "files", "empty_file.csv")
    assert File.exist?(empty_csv_path), "The test CSV file was not found."
    empty_file = Rack::Test::UploadedFile.new(empty_csv_path, "text/csv")

    post import_path, params: { production_file: empty_file }
    assert_response :bad_request
    assert_equal "Empty CSV file", @response.body
  end

  test "should raise CSV parsing error" do
    malformed_csv_path = Rails.root.join("test", "fixtures", "files", "malformed_file.csv")
    assert File.exist?(malformed_csv_path), "The test CSV file was not found."
    malformed_file = Rack::Test::UploadedFile.new(malformed_csv_path, "text/csv")

    post import_path, params: { production_file: malformed_file }
    assert_response :unprocessable_entity
  end

  test "should reject CSV with missing headers" do
    missing_headers_file_path = Rails.root.join("test", "fixtures", "files", "missing_headers.csv")
    assert File.exist?(missing_headers_file_path), "The test CSV file was not found."
    missing_headers_file = Rack::Test::UploadedFile.new(missing_headers_file_path, "text/csv")

    post import_path, params: { production_file: missing_headers_file }
    assert_response :unprocessable_entity
    assert_equal "Missing headers : energy", @response.body
  end
end
