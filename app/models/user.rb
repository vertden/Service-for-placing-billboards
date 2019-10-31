class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :billboard_employments
  def self.make_user_admin(id,admin)
    user = User.find id
    user.update(admin: admin)
  end

  def self.get_billboards_count(user_id)
    count = User.connection.select_all(<<-SQL.squish)
    SELECT u.id,count(be.billboard_id) as count FROM users as u
    INNER JOIN billboard_employments as be
      on be.user_id = u.id
    WHERE CURDATE() BETWEEN be.start_date AND DATE_ADD(be.start_date,INTERVAL be.duration MONTH)
      AND u.id = #{user_id}
    GROUP BY u.id;
    SQL
    begin
      count[0]['count']
    rescue NoMethodError
      0
    end
  end

  def self.get_pay_per_month(user_id)
    price = User.connection.select_all(<<-SQL.squish)
    SELECT u.id,sum(p.price) as price FROM users as u
    INNER JOIN billboard_employments as be
      on be.user_id = u.id
    INNER JOIN billboards as b
      on b.id = be.billboard_id
    INNER JOIN prices as p
      on p.id = b.price_id
    WHERE CURDATE() BETWEEN be.start_date AND DATE_ADD(be.start_date,INTERVAL be.duration MONTH)
      AND u.id = #{user_id}
    group by u.id;
    SQL
    begin
      price[0]['price']
    rescue NoMethodError
      0
    end
  end

  def self.get_employments_stats(user_id)
    record = User.connection.select_all(<<-SQL.squish)
    SELECT b.address,p.price,be.active,
      be.start_date,
      DATE_ADD(be.start_date,INTERVAL be.duration MONTH) as end_of_lease
    FROM users as u
    INNER JOIN billboard_employments as be
      on be.user_id = u.id
    INNER JOIN billboards as b
      on b.id = be.billboard_id
    INNER JOIN prices as p
      on p.id = b.price_id
    WHERE u.id = #{user_id}
    SQL
    record
  end

end

