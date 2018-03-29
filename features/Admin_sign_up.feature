Feature: admin sign up
 
  As an admin
  So that I could have an account
  I want to sign up to the website

Background: suits have been added to database


  And I am on the home page

Scenario: admin signup without password
  When I am on the home page
  And I follow "Admin"
  And I follow "Sign up"
  Then I should be on the adminsignup page 
  And I fill in "Name" with "Henry"
  And I fill in "Email" with "henry@tamu.edu"
  And I press "Create my admin account"
  Then I should see " errors."
  
Scenario: admin signup with password
  When I am on the home page
  And I follow "Admin"
  And I follow "Sign up"
  Then I should be on the adminsignup page 
  And I fill in "Name" with "Henry"
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I fill in "Password Confirmation" with "123456"
  And I press "Create my admin account"
  Then I should see "Welcome to Career Closet Admin Interface! Henry"