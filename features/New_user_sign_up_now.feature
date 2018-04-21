Feature: new user sign up now form login page
 
  As an new user
  So that I can have my account
  I want to sign up to the website

Background: users have been added to database
  Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    | email_confirmed |  password | password_confirmation | 
  | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    flase       |    true         |   123456  |   123456              |         
  | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    true        |    false        |   123456  |   123456              |


Scenario: user log in
  When I am on the login page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see "Listing Appointments"
  And I follow "Log out"
  Then I should see "Log in"
  
Scenario: user log in (sad path)
  When I am on the login page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "1234567"
  And I press "Log in"
  And I should see "Invalid combination of email and password."

Scenario: new user sign up
  When I am on the login page
  And I follow "Sign up now!"
  Then I should be on the signup page 
  And I fill in "First Name" with "Xuezhang"
  And I fill in "Last Name" with "Wu"
  And I fill in "UIN" with "123456791"
  And I fill in "Phone" with "1234567912"
  And I fill in "Email" with "brickhoff@tamu.edu"
  And I fill in "Password" with "123456789"
  And I fill in "Password Confirmation" with "123456789"
  And I press "Create my account"
  Then "brickhoff@tamu.edu" should receive an email 
  Then I should see "Welcome to Career Closet Xuezhang"
  When I open the email with subject "Please confirm your registration."
  When I click the first link in the email
  And I follow "Setting"
  And I should see "Update your profile"
  And I fill in "Phone" with "1234567890"
  And I fill in "Password" with "123456789"
  And I fill in "Password Confirmation" with "123456789"
  And I press "Save change"
  And I should see "Your account was updated successfully"
  

Scenario: new user sign up without password
  When I am on the login page
  And I follow "Sign up now!"
  Then I should be on the signup page 
  And I fill in "First Name" with "Xuezhang"
  And I fill in "Last Name" with "Wu"
  And I fill in "UIN" with "123456789"
  And I fill in "Phone" with "1234567891"
  And I fill in "Email" with "brickhoff@tamu.edu"
  And I press "Create my account"
  Then I should see "The form contains 5 errors"

# to be continued

