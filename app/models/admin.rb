class Admin < ApplicationRecord
  before_save   :downcase_email
  before_create :confirmation_token
  has_many :suit
  attr_accessor :admin_remember_token, :admin_reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  enum codes: [:jzNvvyqZ, :R7BhQG9a, :PncCz4gm, :BsvKCFDT, :pXZEcKp8]

  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  validates :code, presence: true, inclusion: {in: codes},uniqueness: { case_sensitive: true }
  
  has_secure_password
  def Admin.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def Admin.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.admin_remember_token = Admin.new_token
    update_attribute(:remember_digest, Admin.digest(admin_remember_token))
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
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
    self.admin_reset_token = Admin.new_token
    update_attribute(:reset_digest, Admin.digest(admin_reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def send_passward_reset_email
    UserMailer.admin_password_reset(self).deliver_now
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
