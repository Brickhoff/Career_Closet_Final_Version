Feature: new user sign up now form login page
 
  As an new user
  So that I can have my account
  I want to sign up to the website

Background: suits have been added to database


  And I am on the login page

Scenario: new user sign up
  When I am on the login page
  And I follow "Sign up now!"
  Then I should be on the signup page 
  And I fill in "First name" with "Xuezhang"
  And I fill in "Last name" with "Wu"
  And I fill in "UIN" with "123456789"
  And I fill in "Phone" with "1234567891"
  And I fill in "Email" with "brickhoff@tamu.edu"
  And I fill in "password" with "123456789"
  And I fill in "password_confirmation" with "123456789"
  And I press "Create my account"
  Then I should see "Welcome to Career Closet Xuezhang"

Scenario: new user sign up without password
  When I am on the login page
  And I follow "Sign up now!"
  Then I should be on the signup page 
  And I fill in "First name" with "Xuezhang"
  And I fill in "Last name" with "Wu"
  And I fill in "UIN" with "123456789"
  And I fill in "Phone" with "1234567891"
  And I fill in "Email" with "brickhoff@tamu.edu"
  And I press "Create my account"
  Then I should see "The form contains 4 errors"

# to be continued