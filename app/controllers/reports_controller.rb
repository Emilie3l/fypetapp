class ReportsController < ApplicationController
  def index
    @reports = Report.all

    @markers = @reports.geocoded.map do |report|
      {
        lat: report.latitude,
        lng: report.longitude
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
