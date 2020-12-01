class ReportsController < ApplicationController
  before_action :set_pet, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @reports = Report.geocoded.order('created_at DESC')
    # if user_signed_in?
    #   @user_address = current_user.address
    # end
    # @reports = @reports.near(@user_address, 100)
    @markers = @reports.map do |report|
      {
        lat: report.latitude,
        lng: report.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { report: report }),
        image_url: helpers.asset_url(report.pet.category.downcase == "dog" ? 'dog_icon.png' : 'cat_icon.png')
      }
    end
  end

  def create
    @report = Report.new(report_strong_params)
    @report.pet = @pet
    @report.user = current_user

    if @report.save
      redirect_to reports_path
      flash[:notice] = "Your report has been created."
    else
      flash[:alert] = "Still fields without fill up."
      render "reports/new"
    end
  end

  def new
    @report = Report.new
    @report.pet = @pet
  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def report_strong_params
    params.require(:report).permit(:address, :date, :reward_offered, :reward_amount, :status, :pet_id, :user_id)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end
