class Price < ApplicationRecord
  belongs_to :billboard
  validates :billboard_id,presence: true, numericality: true
  validates :price, presence: true,numericality: {greater_than: 0}
  def self.get_price(price_id)
    price = Price.connection.select_all(<<-SQL.squish)
    SELECT p.price as price FROM prices as p
    INNER JOIN billboards as b
    on b.price_id = p.id
    WHERE b.price_id = #{price_id};
    SQL
    price.to_hash[0]['price'] #Extract price
  end

  def self.get_all_prices(billboard_id)
    price = Price.connection.select_all(<<-SQL.squish)
    SELECT p.price,p.created_at FROM prices as p
    LEFT JOIN billboards as b
    on b.price_id = p.id
    WHERE p.billboard_id = #{billboard_id};
    SQL
    price.to_hash #Extract price
  end

end

