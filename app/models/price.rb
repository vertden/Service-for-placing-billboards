class Price < ApplicationRecord
  belongs_to :billboard
  def self.get_price(price_id)
    price = Price.find_by_sql(<<-SQL.squish)
    SELECT p.price as price FROM prices as p
    INNER JOIN billboards as b
    on b.price_id = p.id
    WHERE b.price_id = #{price_id};
    SQL
    price.to_s.scan(/\d/).join('').to_i #Extract price
  end

end
