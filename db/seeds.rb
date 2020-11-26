# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Pet.destroy_all
Report.destroy_all

# Create some users
users = [
  { first_name: "Luigi",
    last_name: "Razum",
    phone_number: "+528001234321",
    address: "Tepic, Nayarit",
    email: "luis@gmail.com",
    password: "test1234"
    },
  { first_name: "Christina",
    last_name: "Bowers",
    phone_number: "+528001234321",
    address: "CDMX",
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
  user = User.new(user)
  user.save
end
puts "Users were created."

# pets = []
pet_number = 1
pet_name = ["Unknown", "Taquito", "Rufus", "Guffy", "Lady", "Candy", "Minie"]
pet_breed = ["Chihuahua", "German Sheppard", "Grant Danes", "Mixed"]
pet_size = ["Small", "Medium", "Large"]
pet_color = ["White", "Black", "Gold", "Cream", "Brown"]
pet_gender = ["Male", "Female", "Unknown"]
pet_age = [1, 3, 4, 6, 5, 9, 8, 13, 2]
pet_traits = "Traits go in here, and could be a short description too."
pet_category = ["dog", "cat"]

puts ""
puts ""
puts "Creating some pets..."
20.times do
  pet = Pet.new
  pet.name = pet_name.sample
  pet.breed = pet_breed.sample
  pet.size = pet_size.sample
  pet.color = pet_color.sample
  pet.gender = pet_gender.sample
  pet.age = pet_age.sample
  pet.traits = pet_traits
  pet.category = pet_category.sample
  pet.save
  puts "Pet #{pet_number}, named #{pet.name} was created."
  pet_number += 1
end
puts "Pets were created..."
puts ""
puts ""
report_address = ["CDMX", "JALISCO", "NAYARIT", "CHIHUAHUA", "TABASCO", "EDO MEX", "SONORA"]
report_reward = [ 0, 100, 300, 200, 150, 500, 1000, 1500, 450 ]
report_status = ["Missing", "Found", "Reunited"]

puts "Creating some reports"
50.times do
  report = Report.new
  report.address = report_address.sample
  report.date = Date.today
  report.status = report_status.sample
  report.reward_amount = report_reward.sample
  report.reward_offered = report.reward_amount != 0
  report.user = User.all.sample
  report.pet = Pet.all.sample
  report.save
  puts "Report #{report.id} has been created."
end
puts "Reports were created"
