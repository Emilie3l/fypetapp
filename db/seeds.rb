# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

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

pet_photos = [
"https://images.dog.ceo/breeds/australian-shepherd/sadie.jpg",
"https://images.dog.ceo/breeds/spaniel-welsh/n02102177_4181.jpg",
"https://images.dog.ceo/breeds/komondor/n02105505_3328.jpg",
"https://images.dog.ceo/breeds/lhasa/n02098413_20614.jpg",
"https://images.dog.ceo/breeds/poodle-standard/n02113799_6891.jpg",
"https://images.dog.ceo/breeds/airedale/n02096051_8892.jpg",
"https://images.dog.ceo/breeds/spaniel-welsh/n02102177_922.jpg",
"https://images.dog.ceo/breeds/husky/n02110185_4030.jpg",
"https://images.dog.ceo/breeds/mastiff-tibetan/n02108551_4698.jpg",
"https://images.dog.ceo/breeds/schnauzer-giant/n02097130_1287.jpg",
"https://images.dog.ceo/breeds/hound-english/n02089973_809.jpg",
"https://images.dog.ceo/breeds/greyhound-italian/n02091032_4970.jpg",
"https://images.dog.ceo/breeds/pekinese/n02086079_1820.jpg",
"https://images.dog.ceo/breeds/spaniel-japanese/n02085782_4351.jpg",
"https://images.dog.ceo/breeds/spaniel-irish/n02102973_2384.jpg",
"https://images.dog.ceo/breeds/mexicanhairless/n02113978_1006.jpg",
"https://images.dog.ceo/breeds/rottweiler/n02106550_1388.jpg",
"https://images.dog.ceo/breeds/basenji/n02110806_5744.jpg",
"https://images.dog.ceo/breeds/spaniel-blenheim/n02086646_554.jpg",
"https://images.dog.ceo/breeds/cairn/n02096177_12882.jpg",
"https://images.dog.ceo/breeds/poodle-miniature/n02113712_2379.jpg",
"https://images.dog.ceo/breeds/setter-gordon/n02101006_922.jpg",
"https://images.dog.ceo/breeds/elkhound-norwegian/n02091467_2298.jpg",
"https://images.dog.ceo/breeds/hound-basset/n02088238_658.jpg",
"https://images.dog.ceo/breeds/havanese/00100trPORTRAIT_00100_BURST20191112123933390_COVER.jpg",
"https://images.dog.ceo/breeds/schipperke/n02104365_9611.jpg",
"https://images.dog.ceo/breeds/cotondetulear/100_2013.jpg",
"https://images.dog.ceo/breeds/hound-english/n02089973_569.jpg",
"https://images.dog.ceo/breeds/spaniel-welsh/n02102177_1833.jpg",
"https://images.dog.ceo/breeds/spaniel-cocker/n02102318_9256.jpg",
"https://images.dog.ceo/breeds/otterhound/n02091635_1372.jpg",
"https://images.dog.ceo/breeds/redbone/n02090379_2126.jpg",
"https://images.dog.ceo/breeds/setter-irish/n02100877_5925.jpg",
"https://images.dog.ceo/breeds/akita/An_Akita_Inu_resting.jpg",
"https://images.dog.ceo/breeds/terrier-irish/n02093991_2765.jpg",
"https://images.dog.ceo/breeds/australian-shepherd/sadie.jpg",
"https://images.dog.ceo/breeds/puggle/IMG_074816.jpg",
"https://images.dog.ceo/breeds/vizsla/n02100583_11289.jpg",
"https://images.dog.ceo/breeds/springer-english/n02102040_6846.jpg",
"https://images.dog.ceo/breeds/deerhound-scottish/n02092002_6625.jpg",
"https://images.dog.ceo/breeds/setter-irish/n02100877_602.jpg",
"https://images.dog.ceo/breeds/boxer/n02108089_3236.jpg",
"https://images.dog.ceo/breeds/dane-great/n02109047_946.jpg",
"https://images.dog.ceo/breeds/wolfhound-irish/n02090721_4130.jpg",
"https://images.dog.ceo/breeds/beagle/n02088364_12102.jpg",
"https://images.dog.ceo/breeds/cattledog-australian/IMG_7057.jpg",
"https://images.dog.ceo/breeds/mountain-swiss/n02107574_3132.jpg",
"https://images.dog.ceo/breeds/terrier-wheaten/n02098105_162.jpg",
"https://images.dog.ceo/breeds/komondor/n02105505_475.jpg",
"https://images.dog.ceo/breeds/malinois/n02105162_9995.jpg"
]

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
  file=URI.open(pet_photos.sample)
  pet.photo.attach(io: file, filename: 'pet.jpg', content_type: 'image/jpg')

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
