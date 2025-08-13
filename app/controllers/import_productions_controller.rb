class ImportProductionsController < ApplicationController
  def index
  end

  def import
    uploaded_file = params[:production_file]
    Rails.logger.info uploaded_file
    render uploaded_file
  end
end
