class Renter < ApplicationRecord
    belongs_to :suit
    belongs_to :user
    enum statuses: [:Available, :Reserved, :Checkout, :Damaged]
    
    validates :suit_id, presence: true
    validates :user_id, presence: true
    
    
end
