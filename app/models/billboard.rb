class Billboard < ApplicationRecord
  validates :address, presence: true, length: {minimum: 5}

  has_many :billboard_employments
  has_many :comments, dependent: :destroy
  has_many :prices, dependent: :destroy
  mount_uploader :photo, AvatarUploader
  geocoded_by :get_full_address
  after_validation :geocode

  def get_full_address
    [address, " Минск"].compact.join(', ')
  end

  def self.set_price(billboard_id, price_id)
    record = Billboard.find billboard_id
    record.update(price_id: price_id)
  end

end
