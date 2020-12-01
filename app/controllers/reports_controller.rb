class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
<<<<<<< Updated upstream
    if params[:query].present?
      @reports = Report.where(address: params[:query])
    end
=======
    #if params[:query].present?
     #results = Geocoder.search(params[:query.to_s])
     #Report.geocoded.near(results)
      #@reports = Report.where(address: params[:query])
    #end
>>>>>>> Stashed changes
    if user_signed_in?
      @user_address = current_user.address
      @reports = Report.geocoded.near(@user_address, 50)
    else
      @reports = Report.geocoded
    end
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
    @report = Report.new(report_strong_params)

    @pet = Pet.find(params[:pet_id])
    @report.pet = @pet
    @report.user = current_user

    if @report.save
      redirect_to reports_path
    else
      render "reports/new"
    end
  end

  def new
    @report = Report.new
    @pet = Pet.find(params[:pet_id])
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
    params.require(:report).permit(:address, :date, :reward_offered, :reward_amount)
  end
end
