class Report < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :user, :pet, :address, :date, :status, presence: true

  belongs_to :pet, dependent: :destroy
  belongs_to :user
end
