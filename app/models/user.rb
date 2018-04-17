class User < ApplicationRecord
  before_save   :downcase_email
  before_create :confirmation_token
  has_many :renters
  has_many :histories
  has_many :appointments
  has_many :suits, :through => :renters
  #scope :uin, -> {where(:uin => true)}
  
  attr_accessor :remember_token, :reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :uin, presence: true, uniqueness: true, length:{minimum: 9, maximum: 9}
  validates :phone, presence: true, uniqueness: true, length:{minimum: 10, maximum: 10}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  has_secure_password
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def full_name
    first_name + " " + last_name
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def send_passward_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  
  private
  
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
  
  def downcase_email
      self.email = email.downcase
  end
  
  
end
