class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 30}
  validates :nickname, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 5 }
  validates :gender, presence: true
  validates :email, presence: true, length: {maximum: 255},
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
#   before_validation { email.downcase! }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }
  has_many :stories

  enum gender: { 男性:1, 女性:2 }
  enum maritalstatus: { 未婚:1, 既婚:2 }
  enum prefecture: {
      北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
      茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
      新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
      岐阜県:21,静岡県:22,愛知県:23,三重県:24,
      滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
      鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
      徳島県:36,香川県:37,愛媛県:38,高知県:39,
      福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46, 
      沖縄県:47
  }

  def reject_destroy_admin
      if User.where(admin: true).count == 1
          user = User.where(admin: true)
          throw :abort if user[0] == self
      end
  end

  def reject_update_admin
      if User.where(admin: true).count == 1 && admin == false
          user = User.where(admin: true)
          if user[0] == self
              errors.add(:user, '更新にエラーがあります。現在あなたのみが管理人のため管理人から外れることはできません。')
              throw :abort
          end
      end
  end
end

