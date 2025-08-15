class ImportProductionsController < ApplicationController
  def index
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.today

    @production_data = PowerInverterProduction.identifiers.map { |identifier| 
      { name: identifier, data: PowerInverterProduction.production(identifier, @selected_date) }
    }
  end

  def import
    uploaded_file = params[:production_file]

    if uploaded_file.respond_to?(:read)
      uploaded_file.rewind
    else
      error_message = "The file sent is invalid"
      flash.now[:alert] = error_message
      render :index, status: :bad_request and return
    end

    csv_content = uploaded_file.read
    if csv_content.blank?
      error_message = "Empty CSV file"
      flash.now[:alert] = error_message
      render :index, status: :bad_request and return
    end

    csv_data = CSV.parse(csv_content, headers: true)
    required_headers = [ "identifier", "datetime", "energy" ]
    csv_headers = csv_data.headers
    missing_headers = required_headers - csv_headers
    unless missing_headers.empty?
      error_message = "Missing headers : #{missing_headers.join(', ')}"
      flash.now[:alert] = error_message
      render :index, status: :unprocessable_entity and return
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
      render :index, status: :unprocessable_entity and return
    end

    flash.now[:notice] = "Successfully imported the CSV file."
    render :index, status: :created
  end
end
