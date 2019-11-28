class BillboardEmployment < ApplicationRecord
  ADV_TYPES = %w(commercial social)

  belongs_to :billboard
  belongs_to :user

  validates :brand, presence: true
  validates :body, presence: true
  validates :adv_type, presence: true
  validates :billboard_id, presence: true, numericality: {greater_than: 0}
  validates :start_date, presence: true, date: {after: Proc.new { Time.now }}
  validates :duration, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :user_id, presence: true, numericality: {greater_than: 0}
  scope :usage_date, -> { where(":date BETWEEN start_date AND DATE_ADD(start_date,INTERVAL duration MONTH)",
                                  {date: Date.today}) }

end

