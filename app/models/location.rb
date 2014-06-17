class Location < ActiveRecord::Base
  
  # Relationship
  belongs_to :user, :dependent => :destroy
  
  # GEOCODE
  geocoded_by :address
  after_validation :geocode #, :if => :address_changed?
  
  
  def address
    if address_two.nil?
      [address_one, city, state, zip].compact.join(' ')
    else 
      [address_one, address_two, city, state, zip].compact.join(' ')
    end
  end 
end
