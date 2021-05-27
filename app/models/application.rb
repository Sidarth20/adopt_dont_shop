class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def form_incomplete?
    self.name.blank? || self.street_address.blank? || self.city.blank? ||
    self.state.blank? || self.zip_code.blank?
  end

  def count_pets
    pets.count
  end

  def pending_applications
    select('shelters.*')
    .joins(pets: :shelter)
    .where(application_status: 'Pending')
  end
end
