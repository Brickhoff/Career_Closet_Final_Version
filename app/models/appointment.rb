class Appointment < ApplicationRecord
        belongs_to :user
        validates :time, presence: true
        validates :user_id, presence: true
end
