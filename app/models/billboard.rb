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

  def self.get_days_of_use(billboard_id)
    days_of_use = Billboard.connection.select_all(<<-SQL.squish)
      SELECT b.id, 
       SUM(IF(DATE_ADD(b_e.start_date,INTERVAL duration MONTH) <= CURDATE(),
         DATEDIFF(DATE_ADD(b_e.start_date,INTERVAL duration MONTH),b_e.start_date),
         IF(b_e.start_date <= CURDATE(), DATEDIFF(CURDATE(),b_e.start_date),0 ) )) as days_of_use
       FROM billboard_employments as b_e
       RIGHT JOIN billboards as b
         on b.id = b_e.billboard_id
       WHERE b.id = #{billboard_id}
       GROUP BY b.id;
    SQL
    days_of_use.to_hash[0]["days_of_use"]
  end

  def self.get_days_of_inactivity(billboard_id)
    days_of_inactivity = Billboard.connection.select_all(<<-SQL.squish)
       SELECT selected.id, DATEDIFF(CURDATE(),b.created_at + selected.days_of_use) as days_of_inactivity 
       FROM
         (SELECT b.id, 
       SUM(IF(DATE_ADD(b_e.start_date,INTERVAL duration MONTH) <= CURDATE(),
         DATEDIFF(DATE_ADD(b_e.start_date,INTERVAL duration MONTH),b_e.start_date),
         IF(b_e.start_date <= CURDATE(), DATEDIFF(CURDATE(),b_e.start_date),0 ) )) as days_of_use
       FROM billboard_employments as b_e
       RIGHT JOIN billboards as b
         on b.id = b_e.billboard_id
       GROUP BY b.id) as selected
       LEFT JOIN billboards as b
         on b.id = selected.id
       WHERE b.id = #{billboard_id};
    SQL
    days_of_inactivity.to_hash[0]["days_of_inactivity"]
  end

  def self.get_free_billboards
    not_active = Billboard.connection.select_all(<<-SQL.squish)
      SELECT b.id,b.address FROM billboards as b
      INNER JOIN billboard_employments as b_e
	      on b.id = b_e.billboard_id
      WHERE CURDATE() NOT BETWEEN b_e.start_date and DATE_ADD(b_e.start_date,INTERVAL duration MONTH)
      GROUP BY b.id,b.address;
    SQL
    not_active.to_hash

  end

  def self.update_params
    Billboard.connection.select_all(<<-SQL.squish)
      UPDATE billboards as b 
      JOIN billboard_employments as be
        on be.billboard_id = b.id
      SET b.adv_type = IF(CURDATE() BETWEEN be.start_date AND DATE_ADD(be.start_date,INTERVAL be.duration MONTH),
        be.adv_type,null),
      b.brand = IF(CURDATE() BETWEEN be.start_date AND DATE_ADD(be.start_date,INTERVAL be.duration MONTH),
        be.brand,null);
    SQL
  end

end

