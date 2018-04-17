class UserMailer < ApplicationMailer
    default :from => "nonreply@mydomain.com"
    
    def registration_confirmation(user)
        @user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Please confirm your registration.")
    end
    
    def suit_rental(user,suit,renter)
        @user = user
        @suit = suit
        @renter = renter
        mail(:to => "#{user.first_name} <#{user.email}>", :subject =>"You have rented a suit from TAMU Closet")
    end
    
    def suit_return(user,suit,renter)
        @user = user
        @suit = suit
        @renter = renter
        mail(:to => "#{user.first_name} <#{user.email}>", :subject =>"The suit you rented was returned to TAMU Closet")
    end
    
    def suit_return_reminder(user,suit,renter)
        @user = user
        @suit = suit
        @renter = renter
        mail(:to => "#{user.first_name} <#{user.email}>", :subject =>"Please return the rental suit to TAMU Closet")
    end
    
    def password_reset(user)
        @user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject =>"Password reset")
    end
    
end
