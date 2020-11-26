class Pet < ApplicationRecord
  validates :breed, :size, :color, :category, presence: true

  has_many :reports
  has_many :users, through: :reports

  has_many_attached :photos
end
