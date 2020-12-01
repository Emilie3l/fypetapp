class Pet < ApplicationRecord
  validates :breed, :size, :color, :category, :photo, presence: true

  has_many :reports, dependent: :destroy
  has_many :users, through: :reports

  has_one_attached :photo
end
