class Suit < ApplicationRecord
  has_many :renters
  has_many :users, :through => :renters
  enum statuses: [:Available, :Reserved, :Checkout, :Damaged]
  enum genders:[:M, :G]
  
  validates :appid, presence: true, uniqueness: {case_sensitive: false}
  validates :gender, presence: true, inclusion: {in: genders}
  validates :article, presence: true
  validates :size, presence: true
  validates :status, presence: true, inclusion: {in: statuses}
    
  def isAvailable?
    status == "Available"
  end
end
