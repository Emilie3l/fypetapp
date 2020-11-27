class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new ]

  def create
  end

  def new
  end
end
