class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :feedback, :message ]

  def home
    @recent_reunited = Report.where(reunited: true).order('created_at DESC').limit(30).sample(3)
    @testimonials = ["'So happy to be reunited with my best friend!!!'", "'I’m so relieved I found my little baby safe and sound. Couldn’t have done it without FYP!'", "'Finally an awesome app to find you lost pet!'"]
    @user_photos = ["https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg", "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80", "https://images.unsplash.com/photo-1495366691023-cc4eadcc2d7e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"]
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
