class Billboard < ApplicationRecord
  has_many :billboard_employments
  mount_uploader :photo, AvatarUploader
  geocoded_by :get_full_address
  after_validation :geocode
  def get_full_address
    [address, " Минск"].compact.join(', ')
  end
end
