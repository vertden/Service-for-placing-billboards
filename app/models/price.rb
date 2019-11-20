class Price < ApplicationRecord
  belongs_to :billboard
  validates :billboard_id, presence: true, numericality: true
  validates :price, presence: true, numericality: {greater_than: 0}

  def self.get_price(price_id)
    # Find price for billboard
    Price.joins(:billboard).where(prices: {id: price_id})[0].price
  end

  def self.get_all_prices(billboard_id)
    # Find all prices for all the time for billboard
    Price.joins(:billboard).where(prices: {billboard_id: billboard_id})
  end

end

