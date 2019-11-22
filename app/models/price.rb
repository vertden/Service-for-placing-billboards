class Price < ApplicationRecord
  belongs_to :billboard, validate: true
  validates :billboard_id, presence: true, numericality: true
  validates :price, presence: true, numericality: {greater_than: 0}

end

