require "open-uri"
require "json"

class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new ]

  def create
    @pet = Pet.new(pet_strong_params)
    authorize @pet

    @report = Report.new

    if @pet.save
      redirect_to new_pet_report_path(@pet, @report)
    else
      flash[:alert] = "👀 Please fill up all the fields."
      render "pets/new"
    end
  end

  def new
    @pet = Pet.new
    @breeds = all_breeds
    authorize @pet
  end

  private
  def pet_strong_params
    params.require(:pet).permit(:name, :category, :color, :size, :gender, :age, :traits, :breed, :photo)
  end

  def all_breeds
    all_breeds = []
    dog_breeds = get_dog_breeds
    cat_breeds = get_cat_breeds
    dog_breeds.each { |dog| all_breeds.push(dog) }
    cat_breeds.each { |cat| all_breeds.push(cat) }
    all_breeds.push("Mixed")
    all_breeds.push("Unknown")
  end

  def get_dog_breeds
    dog_breeds_parsed = fetch_dog_breeds
    dog_breeds_list = []
    
    if dog_breeds_parsed["status"] == "success"
      dog_breeds = dog_breeds_parsed.slice("message")
      dog_breeds["message"].each do |key, value|
        if value.empty?
          dog_breeds_list.push(key.capitalize)
        else
          value.each do |sub_breed|
            compound_breed = "#{sub_breed.capitalize} #{key.capitalize}"
            dog_breeds_list.push(compound_breed)
          end
        end
      end
    end
    dog_breeds_list
  end

  def fetch_dog_breeds
    dog_breeds_url = 'https://dog.ceo/api/breeds/list/all'
    fetch_json(dog_breeds_url)
  end

  def get_cat_breeds
    cat_breeds_parsed = fetch_cat_breeds
    cat_breeds = cat_breeds_parsed.map { |cat_breed| cat_breed.slice("name") }
    cat_breeds_list = cat_breeds.map { |breed| breed["name"] }
  end

  def fetch_json(url)
    raw_json = open(url).read
    JSON.parse(raw_json)
  end

  def fetch_cat_breeds
    cat_breeds_url = 'https://api.thecatapi.com/v1/breeds'
    fetch_json(cat_breeds_url)
  end
end
