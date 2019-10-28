class BillboardEmployment < ApplicationRecord
  validates :brand, presence: true
  validates :body, presence: true, length: {minimum: 5}
  validates :start_date, presence: true
  validates :duration, presence: true
  belongs_to :billboard

  def self.confirm(id)
    record = BillboardEmployment.find id
    record.update(active: false)
  end
  def delete(id)
    record = BillboardEmployment.find id
    record.destroy
  end

end
