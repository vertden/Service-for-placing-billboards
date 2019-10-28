class Billboard < ApplicationRecord
  validates :address, presence: true, length: {minimum: 5}
  validates :price, numericality: {greater_than_or_equal_to: 10}

  has_many :billboard_employments
  has_many :comments, dependent: :destroy
  mount_uploader :photo, AvatarUploader
  geocoded_by :get_full_address
  after_validation :geocode
  def get_full_address
    [address, " Минск"].compact.join(', ')
  end

end
