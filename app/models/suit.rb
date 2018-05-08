class Suit < ApplicationRecord
  has_many :renters
  has_many :histories
  has_many :users, :through => :renters
  #scope :appid, -> {where(:appid => true)}
  enum statuses: [:Available, :Reserved, :Checkout, :Damaged]
  enum genders:[:M, :F]
  #enum style: [:appid, :gender, :size, :article, :status]
  
  validates :appid, presence: true, uniqueness: {case_sensitive: false}
  validates :gender, presence: true, inclusion: {in: genders}
  validates :article, presence: true
  validates :size, presence: true
  validates :status, presence: true, inclusion: {in: statuses}
=begin
  def isAvailable?
    status == "Available"
  end
=end
end
