class ReportsController < ApplicationController
  before_action :set_pet, only: [:new, :create]
  before_action :set_report, only: [:edit, :update]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    dropdowns_query = Hash.new
    dropdowns_query[:category] = params[:category] if params[:category].present?
    params[:breed] = "" unless params[:category].present?
    
    dropdowns_query[:color] = params[:color] if params[:color].present?
    dropdowns_query[:breed] = params[:breed] if params[:breed].present?
    
    results = policy_scope(Report)

    if params[:query]
      @center = Geocoder.search(params[:query]).first.coordinates
      results_by_loc = results.geocoded.near(@center, 50).order('date DESC')
    else
      results_by_loc = results
    end

    unless dropdowns_query.empty?
      @reports = results_by_loc.joins(:pet).where(pets: dropdowns_query).order('date DESC')
    else
      @reports = results_by_loc
    end
    # unless dropdowns_query.empty?
    #   @reports = results.joins(:pet).where(pets: dropdowns_query).order('date DESC')
    # else
    #   if params[:query]
    #     @center = Geocoder.search(params[:query]).first.coordinates
    #     @reports = results.geocoded.near(@center, 150).order('date DESC')
    #   elsif user_signed_in?
    #     @user_address = current_user.address
    #     unless @user_address.empty?
    #       @center = Geocoder.search(@user_address).first.coordinates
    #       @reports = results.geocoded.near(@center, 50).order('date DESC')
    #     else
    #       @reports = results.geocoded.order('date DESC')
    #     end
    #   else
    #     @reports = results.geocoded.order('date DESC')
    #   end
    # end

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
    authorize @report
    
    @report.pet = @pet
    @report.user = current_user
    
    if @report.save
      redirect_to reports_path
      flash[:notice] = "Your report has been created 🙏, feedback is on its way 🤞"
    else
      flash[:alert] = "👀 Please fill up all the fields."
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
    authorize @report
  end
  
  def edit
  end
  
  def update
    if params[:reunited]
      reunited = params.require(:reunited)
      reunited_date = reunited == "true" ? Date.today : nil
      @report.reunited = reunited
      @report.reunited_date = reunited_date
    else
      @report.update(report_strong_params)
    end

    if @report.save
      redirect_to report_path
      if params[:reunited]
        if @report.reunited
          flash[:notice] = "These are greats news!! 🎊 Congrats!! 🎉"
        else
          flash[:notice] = "😢 So bad to hear that. 🤞 Don't lose hope."
        end
      else
        flash[:notice] = "👍 It's good to keep updated your reports. 🤞 Don't lose hope."
      end
    else
      render "edit"
      flash[:alert] = "🙇‍♂️ We couldn't update the report."
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
    flash[:alert] = "⛔ You can modify your own reports only."
    redirect_to(report_path)
  end
end
