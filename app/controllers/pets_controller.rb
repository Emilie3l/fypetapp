class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new ]

  def create
    @pet = Pet.new(pet_strong_params)
    authorize @pet

    @report = Report.new

    if @pet.save
      redirect_to new_pet_report_path(@pet, @report)
    else
      flash[:alert] = "Still fields without fill up."
      render "pets/new"
    end
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  private

  def pet_strong_params
    params.require(:pet).permit(:name, :category, :color, :size, :gender, :age, :traits, :breed, :photo)
  end
end
