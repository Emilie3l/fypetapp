class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :feedback, :message ]

  def home
    @recent_reunited = Report.where(reunited: true).order('created_at DESC').limit(30).sample(3)
  end

  def myreports
    @reports = Report.where(user: current_user)
  end

  def feedback
    @report = Report.find(params[:id])
  end

  def message
    redirect_to reports_path
    flash[:notice] = "Your message has been sended. Thank you for your help!"
  end
end
