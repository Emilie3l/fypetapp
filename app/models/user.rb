class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone_number, :address, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :reports
  has_many :pets, through: :reports

  has_one_attached :profile_photo
end
