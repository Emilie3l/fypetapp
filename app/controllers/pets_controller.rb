class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new ]

  def create
    @report = Report.new

    @pet = Pet.new(pet_strong_params)

    if @pet.save
      redirect_to new_pet_report_path(@pet, @report)
    else
      render "pets/new"
    end
  end

  def new
    @pet = Pet.new
  end

  private

  def pet_strong_params
    params.require(:pet).permit(:name, :category, :color, :size, :gender, :age, :traits, :breed, :photo)
  end
end


