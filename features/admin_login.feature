Feature: admin login
 
  As an admin
  So that I make operations
  I want to login to the website

Background: admins in database
  Given the following admins exist:
  | name      |    email       | password | password_confirmation | 
  | Cathy     | cathy@tamu.edu | 123456   |   123456              |         
  | Brick     | bk@tamu.edu    | 123456   |   123456              |

Scenario: admin login
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page

Scenario: admin cannot login successfully(sad path)
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456789"
  And I press "Log in"
  Then I should be on the adminlogin page