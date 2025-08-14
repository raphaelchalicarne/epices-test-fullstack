class ImportProductionsController < ApplicationController
  def index
  end

  def import
    uploaded_file = params[:production_file]

    if uploaded_file.respond_to?(:read)
      uploaded_file.rewind
    else
      render plain: "The file sent is invalid", status: :bad_request and return
    end

    csv_content = uploaded_file.read
    if csv_content.blank?
      render plain: "Empty CSV file", status: :bad_request and return
    end

    begin
      csv_data = CSV.parse(csv_content, headers: true)
    rescue CSV::MalformedCSVError => e
      render plain: "CSV parsing error : #{e.message}", status: :unprocessable_entity and return
    end

    csv_data.each do |row|
      PowerInverterProduction.create!(
        identifier: row["identifier"],
        datetime: DateTime.strptime(row["datetime"].to_s, "%d/%m/%y %H:%M"),
        energy: row["energy"]
      )
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Successfully imported the CSV file." }
    end
  end
end
