class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @recent_reunited = Report.where("status = :status", status: 'Reunited').order('created_at DESC').limit(3)
  end
end
