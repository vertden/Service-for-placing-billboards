class BillboardEmployment < ApplicationRecord
  validates :brand, presence: true
  validates :body, presence: true, length: {minimum: 5}
  validates :start_date, presence: true
  validates :duration, presence: true
  belongs_to :billboard
end
