class ReportsController < ApplicationController
  before_action :set_pet, only: [:new, :create]
  before_action :set_report, only: [:update]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    dropdowns_query = Hash.new
    dropdowns_query[:category] = params[:category] if params[:category].present?
    dropdowns_query[:color] = params[:color] if params[:color].present?
    dropdowns_query[:breed] = params[:breed] if params[:breed].present?
    
    results = policy_scope(Report)

    unless dropdowns_query.empty?
      @reports = Report.joins(:pet).where(pets: dropdowns_query)
    else
      @reports = results.order('date DESC')
    end
    # raise
    # if params[:category].present? && params[:color].present? && params[:breed].present?
    #   results = Report.joins(:pet).where("pets.category ILIKE ? AND pets.color ILIKE ? AND pets.breed ILIKE ? ", params[:category], params[:color], params[:breed])

    # elsif params[:category].present?
    #   results = Report.joins(:pet).where("pets.category ILIKE ?", params[:category])

    # elsif params[:color].present?
    #   results = Report.joins(:pet).where("pets.color ILIKE ?", params[:color])

    # elsif params[:breed].present?
    #   results = Report.joins(:pet).where("pets.breed ILIKE ?", params[:breed])
    # end

    if params[:query]
        @center = Geocoder.search(params[:query]).first.coordinates
        @reports = results.geocoded.near(@center, 150).order('date DESC')
      elsif user_signed_in?
        @user_address = current_user.address
        @center = Geocoder.search(@user_address).first.coordinates
        if @user_address
          @reports = results.geocoded.near(@center, 50).order('date DESC')
        else
          @reports = results.geocoded.order('date DESC')
        end
    else
      @reports = results.geocoded.order('date DESC')
     end

    @markers = @reports.map do |report|
      {
        lat: report.latitude,
        lng: report.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { report: report }),
        image_url: helpers.asset_url(report.pet.category.downcase == "dog" ? 'dog_icon.png' : 'cat_icon.png'),
      }
    end
  end

  def create
    @report = Report.new(report_strong_params)
    authorize @report

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
    authorize @report
  end

  def show
    @report = Report.find(params[:id])
    @pet = @report.pet
    authorize @report
  end

  def edit
  end

  def update
    reunited = params.require(:reunited)
    flash_show = reunited == "true" ? "Reunited" : "Un-Reunited"
    reunited_date = reunited == "true" ? Date.today : nil
    @report.reunited = reunited
    @report.reunited_date = reunited_date

    if @report.save
      redirect_to report_path
      flash[:notice] = "Your report has been marked as #{flash_show}."
    else
      redirect_to report_path
      flash[:alert] = "We couldn't update the report."
    end
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

  def set_report
    report_id = params.require(:id)
    @report = Report.find(report_id)
    authorize @report
  end

  def user_not_authorized
    flash[:alert] = "You can modify your own reports."
    redirect_to(report_path)
  end
end
