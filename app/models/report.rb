class Report < ApplicationRecord
  validates :user, :pet, :address, :date, :status, presence: true

  belongs_to :pet
  belongs_to :user
end
