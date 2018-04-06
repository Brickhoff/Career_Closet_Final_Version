class Renter < ApplicationRecord
    belongs_to :suit
    belongs_to :user
    enum statuses: [:Available, :Reserved, :Checkout, :Damaged]
    #scope :with_uin_and_appid, -> {joins(:user).merge(User.uin).joins(:suit).merge(Suit.appid)}
    
    validates :suit_id, presence: true
    validates :user_id, presence: true
    
    
end
