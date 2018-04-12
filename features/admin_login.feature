Feature: admin login
 
  As an admin
  So that I make operations
  I want to login to the website

Background: admins in database
  Given the following admins exist:
  | name      |    email       | password | password_confirmation | 
  | Cathy     | cathy@tamu.edu | 123456   |   123456              |         
  | Brick     | bk@tamu.edu    | 123456   |   123456              |
  Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    |  password | password_confirmation | 
  | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    false       | 123456    |   123456              |         
  | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    true        | 123456    |   123456              |

Scenario: admin login, logout and edit.
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  And I follow "Settings"
  And I should see "Update your profile"
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I fill in "Password Confirmation" with "123456"
  And I fill in "Name" with "Brick2"
  And I press "Save changes"
  And I should see "Your account was updated successfully."
  And I follow "Log out"
  Then I should be on the adminlogin page

Scenario: admin cannot login successfully(sad path)
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456789"
  And I press "Log in"
  And I should see "Invalid combination of email and password."
  Then I should be on the adminlogin page
  
Scenario: admin manage users
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  Then I follow "Customers"
  And I should see "All Customers"
  And I should see "123456789"
  And I should see "123456790"