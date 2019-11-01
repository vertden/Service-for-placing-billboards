class BillboardEmployment < ApplicationRecord
  belongs_to :billboard
  belongs_to :user
  validates :brand, presence: true
  validates :body, presence: true, length: {minimum: 5}
  validates :start_date, presence: true, date: { after: Proc.new { Time.now } }
  validates :duration, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :user_id, presence: true, numericality: {greater_than_or_equal_to: 1}
  def self.confirm(id)
    record = BillboardEmployment.find id
    record.update(active: false)
  end

end

