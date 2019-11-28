class Billboard < ApplicationRecord
  has_many :billboard_employments
  has_many :comments, dependent: :destroy
  belongs_to :price, dependent: :destroy, optional: true, validate: true
  mount_uploader :photo, AvatarUploader
  geocoded_by :get_full_address
  validates :address, presence: true, length: {minimum: 5}
  after_validation :geocode

  def get_full_address
    [address, "Минск"].compact.join(', ')
  end

  def get_price
    # Find price for billboard
    Price.joins(:billboard).where(prices: {id: price_id})[0].price
  end

  def get_all_prices
    # Find all prices for all the time for billboard
    Price.joins(:billboard).where(prices: {billboard_id: id})
  end

  def self.get_days_of_use
    @days_of_use = Hash.new(0)
    BillboardEmployment.select(:id, :billboard_id, :start_date, :duration).find_each do |employment|
      end_date = employment.start_date + employment.duration.month
      if end_date <= Date.today
        @days_of_use[employment.billboard_id] += (end_date - employment.start_date).to_i
      elsif employment.start_date <= Date.today
        @days_of_use[employment.billboard_id] += (Date.today - employment.start_date).to_i
      else
        @days_of_use[employment.billboard_id] += 0
      end
    end
    return @days_of_use
  end

  def self.get_days_of_inactivity
    @days_of_inactivity = Hash.new(0)
    BillboardEmployment.select(:id, :billboard_id, :start_date, :duration, "billboards.created_at").
        joins(:billboard).find_each do |employment|
      @days_of_inactivity[employment.billboard_id] +=
          (Date.today - (employment.created_at.to_date + @days_of_use[employment.billboard_id])).to_i
    end
    return @days_of_inactivity
  end

  def self.get_free_billboards
    # Return the list of free billboards
    Billboard.select(:id, :address).joins(:billboard_employments).where("
    :date NOT BETWEEN start_date AND DATE_ADD(start_date,INTERVAL duration MONTH)",
                                                                        date: Date.today).group(:id, :address)
  end

  def self.get_release_date
    # Return date when billboard will become free
    @date = Hash.new(0)
    BillboardEmployment.select(:id, :billboard_id, :start_date, :duration).
        joins(:billboard).where.not(active: true).find_each do |employment|
      end_date = employment.start_date + employment.duration.month
      if end_date >= Date.today
        @date[employment.billboard_id] = end_date
      end
    end
    return @date
  end

  def self.set_price(billboard_id, price_id)
    record = Billboard.find billboard_id
    record.update(price_id: price_id)
  end

  def self.update_params
    # Update brand and adv_type of each billboard
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

