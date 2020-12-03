# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

def generate_a_trait
  rand(7..10) == 10 ? "" : get_trait
end

def generate_pet_category
  rand(7..10) == 10 ? "Cat" : "Dog"
end

def generate_pet_gender
  rand(8..10) == 10 ? "Female" : "Male"
end

def generate_report_reunited
  rand(8..10) == 10 ? false : true
end

def generate_report_status
  rand(7..10) == 10 ? "Lost" : "Missing"
end

def get_pet_name(gender)
  gender == "Male" ? get_male_pet_name : get_female_pet_name
end

def get_trait
  pet_traits = [
    "Will answer to the name 'Ricky Martin' when called",
    "Has a small scar behind left ear",
    "Does not do well with kids",
    "Has a limp on back left foot from an accident as a baby",
    "Has diabetes, please do not feed this dog treats",
    "Shows teeth when excited- looks like they are smiling!",
    "If you look closely at the left ear, it has a small bite taken out",
    "Missing front tooth, you can see this if you gently look into mouth",
    "Lost with a purple bandanna that says 'my human is my best friend'",
    "Allergic to tortillas"
  ]
  pet_traits.sample
end

def get_male_pet_name
  male_pet_names = [
    "Max","Charlie","Cooper","Buddy","Rocky","Bear","Jack","Milo","Duke","Tucker","Oliver","Bentley",
    "Teddy","Beau","Leo","Toby","Jax","Zeus","Winston","Blu","Finn","Louie","Ollie","Murphy","Gus",
    "Moose","Jake","Loki","Dexter","Hank","Bruno","Apollo","Buster","Thor","Bailey","Gunnar","Lucky",
    "Diesel","Harley","Henry","Koda","Jackson","Riley","Ace","Oscar","Chewy","Bandit","Baxter","Scout",
    "Jasper","Maverick","Sam","Cody","Gizmo","Shadow","Simba","Rex","Brody","Tank","Marley","Otis",
    "Remy","Roscoe","Rocco","Sammy","Cash","Boomer","Prince","Benji","Benny","Copper","Archie","Chance",
    "Ranger","Ziggy","Luke","George","Oreo","Hunter","Rusty","King","Odin","Coco","Frankie","Tyson",
    "Chase","Theo","Romeo","Bruce","Rudy","Zeke","Kobe","Peanut","Joey","Oakley","Chico","Mac","Walter",
    "Brutus","Samson","Unknown"
  ]
  male_pet_names.sample
end

def get_female_pet_name
  female_pet_names = [
    "Bella","Luna","Lucy","Daisy","Lily","Zoe","Lola","Sadie","Molly","Bailey","Stella","Maggie","Roxy",
    "Sophie","Chloe","Penny","Coco","Nala","Rosie","Ruby","Gracie","Ellie","Mia","Piper","Callie","Abby",
    "Ginger","Lulu","Pepper","Riley","Willow","Millie","Harley","Sasha","Lexi","Lady","Izzy","Layla",
    "Charlie","Dixie","Maya","Kona","Annie","Olive","Hazel","Winnie","Princess","Emma","Athena","Honey",
    "Belle","Nova","Marley","Ella","Maddie","Cookie","Phoebe","Scout","Minnie","Dakota","Holly","Angel",
    "Harper","Josie","Leia","Ava","Missy","Mila","Sugar","Shelby","Mocha","Poppy","Cleo","Penelope",
    "Ivy","Peanut","Xena","Remi","Fiona","Sandy","Gigi","Bonnie","Macy","Jasmine","Baby","Paisley",
    "Shadow","Koda","Pearl","Delilah","Skye","Nina","Trixie","Charlotte","Arya","Aspen","Georgia",
    "Diamond","Frankie","Grace","Unknown"
  ]
  female_pet_names.sample
end

def fetch_json(url)
  raw_json = open(url).read
  JSON.parse(raw_json)
end

def fetch_dog
  fetched_dog = Hash.new
  get_dog_url = 'https://dog.ceo/api/breeds/image/random'

  dog_json = fetch_json(get_dog_url)

  if dog_json["status"] == "success"
    fetched_dog[:photo_url] = dog_json["message"]
    raw_breed = dog_json["message"].split("/")[4].split("-")
    fetched_dog[:breed] = raw_breed.count == 1 ? raw_breed[0].capitalize : "#{raw_breed[1].capitalize} #{raw_breed[0].capitalize}"
  end

  fetched_dog
end

def fetch_cat_breeds
  cat_breeds_url = 'https://api.thecatapi.com/v1/breeds'
  fetch_json(cat_breeds_url)
end

def sample_cat_breed(cat_breeds)
  array_cat_breeds = []
  cat_breeds.each do |cat_breed|
    array_cat_breeds.push(cat_breed.slice("id","name"))
  end
  array_cat_breeds.sample
end

def go_fetch_a_cat(cat_breed)
  get_cat_url = "https://api.thecatapi.com/v1/images/search?breed_id=#{cat_breed["id"]}"
  cat_json = fetch_json(get_cat_url)
  cat_json.first["url"]
end

def fetch_cat(cat_breed)
  fetched_cat = Hash.new

  fetched_cat[:photo_url] = go_fetch_a_cat(cat_breed)
  fetched_cat[:breed] = cat_breed["name"]

  fetched_cat
end

# User.destroy_all
# Pet.destroy_all

# Create some users
users = [
  { first_name: "Luigi",
    last_name: "Razum",
    phone_number: "+528001234321",
    address: "Av. Mexico 345, Tepic, Nayarit",
    email: "luis@gmail.com",
    password: "test1234"
    },
  { first_name: "Christina",
    last_name: "Bowers",
    phone_number: "+528001234321",
    address: "Michoacán 18, 06100 Mexico City, Mexico",
    email: "chris@gmail.com",
    password: "test1234"
    },
    { first_name: "Emilie",
    last_name: "Lockey",
    phone_number: "+528001234321",
    address: "London, UK",
    email: "emilie@gmail.com",
    password: "test1234"
    },
    { first_name: "John",
    last_name: "McClane",
    phone_number: "+528001234321",
    address: "New York, US",
    email: "john@gmail.com",
    password: "test1234"
    },
    { first_name: "Carolina",
    last_name: "Herrera",
    phone_number: "+528001234321",
    address: "Paris, France",
    email: "carolina@gmail.com",
    password: "test1234"
    },
    { first_name: "Calvin",
    last_name: "Klein",
    phone_number: "+528001234321",
    address: "Los Angeles, CA",
    email: "calvin@gmail.com",
    password: "test1234"
    },
    { first_name: "Francisco",
    last_name: "Pope",
    phone_number: "+528001234321",
    address: "Vatican, ROME",
    email: "pope@gmail.com",
    password: "test1234"
    },
  ]

puts "Creating some users..."
users.each_with_index do |user, index|
  puts "Creating user number #{index+1}"
  new_user = User.new(user)
  new_user.save
  puts "user with id:#{new_user.id}, login:#{new_user.email}, password: #{user[:password]}, was created." 
  puts "-------------------------------------------------------------------------------------------------"
end
puts "Users were created."

pet_size = ["Small", "Medium", "Large"]
pet_color = ["White", "Black", "Gold", "Cream", "Brown"]
pet_age = [1, 3, 4, 6, 5, 9, 8, 13, 2]
all_cat_breeds = fetch_cat_breeds

puts ""
puts ""
puts "Creating some pets..."
75.times do
  pet = Pet.new
  pet.category = generate_pet_category
  pet.gender = generate_pet_gender
  pet.size = pet_size.sample
  pet.color = pet_color.sample
  pet.age = pet_age.sample
  pet.traits = generate_a_trait
  
  pet.name = get_pet_name(pet.gender)
  
  fetched_pet = pet.category == "Dog" ? fetch_dog : fetch_cat(sample_cat_breed(all_cat_breeds))

  pet.breed = fetched_pet[:breed]
  
  file=URI.open(fetched_pet[:photo_url])
  pet.photo.attach(io: file, filename: 'pet.jpg', content_type: 'image/jpg')
  
  pet.save
  puts "Pet #{pet.id}, #{pet.name}, #{pet.gender}, #{pet.category}, #{pet.breed}"
  puts "    photo url: #{fetched_pet[:photo_url]}"
  puts "-------------------------------------------------------------------------------------------------"
end
puts "Pets were created..."
puts ""
puts ""
report_address = ["06100, Cuauhtémoc, Mexico City, Mexico", 
                  "Paseo De La Reforma, 06500 Mexico City, Mexico",
                  "Guanajuato 54, 06700 Mexico City, Mexico",
                  "Álvaro Obregón 213, 06700 Mexico City, Mexico",
                  "Michoacán 134, 06170 Mexico City, Mexico",
                  "Álvaro Obregón 120, 06700 Mexico City, Mexico",
                  "Luis Donaldo Colosio, Tepic, Nayarit, Mexico",
                  "Nuevo León 144, 06100 Mexico City, Mexico",
                  "Sinaloa 236, 06700 Mexico City, Mexico",
                  "Agustín Melgar 6, 06140 Mexico City, Mexico",
                  "Camino a Los Metates 225, Tepic, Nayarit, Mexico",
                  "Jacarandas 88, Tepic, Nayarit, Mexico",
                  "Brasil 234, Tepic, Nayarit, Mexico",
                  "Villahermosa, Tabasco, Mexico",
                  "Ricardo Flores Magón 450, 63197 Tepic, Nayarit, Mexico",
                  "Isabel La Católica 546, 03400 Mexico City, Mexico",
                  "Guadalupe 235, 45040 Zapopan, Jalisco, Mexico",
                  "345 Av Jacarandas, Tepic, Nayarit",
                  "Zapopan 321, Tepic, Nayarit, Mexico",
                  "987 Av Insurgentes, Tepic, Nayarit",
                  "Madre Perla 84, Tepic, Nayarit, Mexico",
                  "45 Bucerias, Tepic, Nayarit",
                  "34 Madre Perla, Tepic, Nayarit",
                  "18 Calle 2, Tepic, Nayarit",
                  "27 Estrella de Mar, Tepic, Nayarit",
                  "León Norte 125, Tepic, Nayarit, Mexico",
                  "Bucerias, Tepic, Nayarit, Mexico",
                  "Langosta, Tepic, Nayarit, Mexico",
                  "Abasolo 34, 63500 Tepic, Nayarit, Mexico" ]
report_reward = [ 0, 100, 300, 200, 150, 500, 1000, 1500, 450 ]

puts "Creating some reports"
Pet.all.each do |pet|
  report = Report.new
  report.address = report_address.sample
  report.date = Date.today - (rand * 63)
  report.status = generate_report_status
  report.reunited = generate_report_reunited
  if report.reunited
    reunited_date = report.date + (rand * 35)
    if reunited_date > Date.today
      reunited_date = Date.today - (rand * 8)
      if reunited_date < report.date
        reunited_date = report.date + (rand * 3)
      end
    end
  end
  report.reunited_date = reunited_date
  report.reward_amount = report_reward.sample
  report.reward_offered = report.reward_amount != 0
  report.user = User.all.sample
  report.pet = pet
  report.save
  puts "Report #{report.id} for #{pet.name} has been created by #{report.user.first_name}."
  puts "-------------------------------------------------------------------------------------------------"
end
puts "Reports were created"
