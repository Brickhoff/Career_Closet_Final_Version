Feature: Use footer to redirect to About and Contact
 
  As an admin
  So that I manage customer and suits
  I want to log in to the website

Background: suits have been added to database


  And I am on the home page

Scenario: admin login
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page 
  And I fill in "Name" with "stjiao13@tamu.edu"
  And I fill in "Password" with "mypassword"
  And I press "Log in"
  Then I should see "Invalid"


# to be continued

