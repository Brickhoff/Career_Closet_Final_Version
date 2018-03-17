Feature: admin sign up
 
  As an admin
  So that I could have an account
  I want to sign up to the website

Background: suits have been added to database


  And I am on the home page

Scenario: admin signup without password
  When I am on the home page
  And I follow "Sign up now!"
  Then I should be on the signup page 
  And I fill in "First name" with "Shutong"
  And I fill in "Last name" with "Jiao"
  And I fill in "UIN" with "123"
  And I fill in "Phone" with "12345676"
  And I fill in "Email" with "stjiao13@tamu.edu"
#   And I fill in "password" with "mypassword"
#   And I fill in "password_confirmation" with "mypassword"
  And I press "Create my account"
  Then I should see " errors."