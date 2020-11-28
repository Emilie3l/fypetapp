class Report < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :user, :pet, :address, :date, presence: true

  belongs_to :user
  belongs_to :pet
end
