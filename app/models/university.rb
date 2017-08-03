class University < ActiveRecord::Base
  belongs_to :user

geocoded_by :full_address
  after_validation :geocode, if: :name_changed?

  def full_address
    "#{name},#{country_code}"
  end

reverse_geocoded_by :latitude, :longitude,
  :address => :address
before_save :reverse_geocode, if: :name_changed?
end
