class ImportProductionsController < ApplicationController
  def index
  end

  def import
    uploaded_file = params[:production_file]
    Rails.logger.info uploaded_file
    if uploaded_file.present?
      csv_data = CSV.parse(uploaded_file.read, headers: true)
      csv_data.each do |row|
        PowerInverterProduction.create(
          identifier: row["identifier"],
          datetime: DateTime.strptime(row["datetime"], "%d/%m/%y %H:%M"),
          energy: row["energy"]
          )
      end
    end
  end
end
