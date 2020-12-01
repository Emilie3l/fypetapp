class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @recent_reunited = Report.where("status = :status", status: 'Reunited').order('created_at DESC').limit(30).sample(3)
  end

  def myreports
    @reports = Report.where(user: current_user)
  end
end
