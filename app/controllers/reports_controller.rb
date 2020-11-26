class ReportsController < ApplicationController
  def index
    @reports = Report.geocoded

    @markers = @reports.map do |report|
      {
        lat: report.latitude,
        lng: report.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { report: report }),
        image_url: helpers.asset_url(report.pet.category == "dog" ? 'dog_icon.png' : 'cat_icon.png')
      }
    end
  end

  def create
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
