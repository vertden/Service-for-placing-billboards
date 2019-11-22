class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :billboard_employments

  validates :first_name, presence: false, length: {minimum: 1}
  validates :second_name, presence: false, length: {minimum: 1}
  validates :nickname, presence: false, length: {minimum: 3}
  validates :birthday, presence: false, date: {before: Proc.new { Time.now }}
  validates :address, presence: false, length: {minimum: 3}

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def make_admin
    update_attribute(:admin, true)
  end

  def remove_admin
    update_attribute(:admin, false)
  end

  def self.get_billboards_count
    # Return how many billboards is user using
    User.joins(:billboard_employments).where("
    :date BETWEEN start_date AND DATE_ADD(start_date,INTERVAL duration MONTH)",
                                             {date: Date.today}).group(:id).count
  end

  def self.get_pay_per_month
    # Return sum that user pay for month
    User.joins(billboard_employments: [billboard: :price]).where("
    :date BETWEEN start_date AND DATE_ADD(start_date,INTERVAL duration MONTH)",
                                                                 {date: Date.today}).group(:id).sum(:price)
  end

  def get_employments_stats
    # Return user employments
    BillboardEmployment.select(:id, 'billboards.address', :billboard_id, :price, :start_date, :duration, :active).
        joins(:user, [billboard: :price]).where('users.id=?', id)
  end

end









