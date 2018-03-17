Feature: user log in
 
  As an user
  So that I make appointments in my account
  I want to log in to the website

Background: suits have been added to database


  And I am on the home page

Scenario: user login
  When I am on the home page
  And I follow "Log in"
  Then I should be on the login page 
  And I fill in "Email" with "brickhoff@tamu.edu"
  And I fill in "Password" with "123456789"
  And I press "Log in"
  Then I should see "Invalid combination of email and password"


# to be continued