Feature: admin login
 
  As an admin
  So that I make operations
  I want to login to the website

Background: admins in database
  Given the following admins exist:
  | name      |    email                | password | password_confirmation | email_confirmed |     code    | superadmin|
  | Cathy     | cathy@tamu.edu          | 123456   |   123456              |      true       |   R7BhQG9a  |   false   |
  | Brick     | bk@tamu.edu             | 123456   |   123456              |      true       |   PncCz4gm  |   false   |
  | Henry     | henry@tamu.edu          | 123456   |   123456              |      false      |   pXZEcKp8  |   false   |
  | HenryS    | henrysurface@gamil.com  | 123456   |   123456              |      true       |   jzNvvyqZ  |   true    |
  Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    |  password | password_confirmation | 
  | Brick         |     Wu      | 123456783 |   1234567890  | bk@tamu.edu    |    true        | 123456    |   123456              |
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
  
  
Scenario: admin forget password(invalid emial)
  When I am on the adminlogin page
  And I follow "forgot password"
  Then I should see "Forgot password"
  And I fill in "Email" with "bk2@tamu.edu"
  And I press "Submit"
  Then I should see "Email address not found"
  
Scenario: admin forget password(valid email)
  When I am on the adminlogin page
  And I follow "forgot password"
  Then I should see "Forgot password"
  And I fill in "Email" with "cathy@tamu.edu"
  And I press "Submit"
  Then I should see "Email sent with password reset instructions"

Scenario: admin change password
  When I am on the adminlogin page
  And I follow "forgot password"
  Then I should see "Forgot password"
  And I fill in "Email" with "cathy@tamu.edu"
  And I press "Submit"
  Then "cathy@tamu.edu" should receive an email
  When I open the email
  Then I should see "Password reset" in the email body
  When I follow "Reset password" in the email
  Then I should see "Reset password"
  And I fill in "admin_password" with "123qwe"
  And I fill in "admin_password_confirmation" with "123qwe"
  And I press "Update password"
  Then I should see "Password has been reset."

Scenario: admin log in(with email confirmed)
  When I am on the adminlogin page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see " Suits inventory"
  And I follow "Log out"
  Then I should see "Log in"
  
Scenario: admin log in (without email confirmed)
  When I am on the adminlogin page
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see "Please activate your account."  

Scenario: admin log in (sad path)
  When I am on the adminlogin page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "1234567"
  And I press "Log in"
  And I should see "Invalid combination of email and password."
  
Scenario: admin delete users
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "henrysurface@gamil.com"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  Then I follow "Customers"
  Then I should see "Delete"
  Then I follow "Delete"
  And I should not see "Brick"
  
Scenario:superadmin delete admin
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "henrysurface@gamil.com"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  Then I follow "Administrators"
  Then I should see "HenryS"
  Then I click the 2 instance of link "Delete"
  Then I should see "The admin is delete."
  
Scenario:superadmin delete admin
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "henrysurface@gamil.com"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  Then I follow "Administrators"
  Then I should see "HenryS"
  Then I click the 0 instance of link "Delete"
  Then I should see "You can not delete super admin account."