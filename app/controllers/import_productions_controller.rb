class ImportProductionsController < ApplicationController
  def index
  end

  def import
    uploaded_file = params[:production_file]

    if uploaded_file.respond_to?(:read)
      uploaded_file.rewind
    else
      error_message = "The file sent is invalid"
      flash.now[:alert] = error_message
      render plain: error_message, status: :bad_request and return
    end

    csv_content = uploaded_file.read
    if csv_content.blank?
      error_message = "Empty CSV file"
      flash.now[:alert] = error_message
      render plain: error_message, status: :bad_request and return
    end

    begin
      csv_data = CSV.parse(csv_content, headers: true)
    rescue CSV::MalformedCSVError => e
      error_message = "CSV parsing error : #{e.message}"
      flash.now[:alert] = error_message
      render plain: error_message, status: :unprocessable_entity and return
    end

    required_headers = [ "identifier", "datetime", "energy" ]
    csv_headers = csv_data.headers
    missing_headers = required_headers - csv_headers
    unless missing_headers.empty?
      error_message = "Missing headers : #{missing_headers.join(', ')}"
      flash.now[:alert] = error_message
      render plain: error_message, status: :unprocessable_entity and return
    end

    begin
      ActiveRecord::Base.transaction do
        csv_data.each do |row|
          begin
            PowerInverterProduction.create!(
              identifier: row["identifier"],
              datetime: DateTime.strptime(row["datetime"].to_s, "%d/%m/%y %H:%M"),
              energy: row["energy"]
            )
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Missing data : #{e.message}"
            raise

          rescue Date::Error => e
            raise
          end
        end
      end
    rescue => e
      error_message = "CSV import error : #{e.message}"
      flash.now[:alert] = error_message
      render plain: error_message, status: :unprocessable_entity and return
    end

    notice_message = "Successfully imported the CSV file."
    flash.now[:notice] = notice_message
    render plain: notice_message, status: :created and return
  end
end
