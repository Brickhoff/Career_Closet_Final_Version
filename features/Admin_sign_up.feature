Feature: admin sign up
 
  As an admin
  So that I could have an account
  I want to sign up to the website



Scenario: admin signup without password
  When I am on the home page
  And I follow "Admin"
  And I follow "Sign up"
  Then I should be on the adminsignup page 
  And I fill in "Name" with "Henry"
  And I fill in "Email" with "henry@tamu.edu"
  And I press "Create my admin account"
  Then I should see " errors."
  
Scenario: admin signup without code
  When I am on the home page
  And I follow "Admin"
  And I follow "Sign up"
  Then I should be on the adminsignup page 
  And I fill in "Name" with "Henry"
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I fill in "Password Confirmation" with "123456"
  And I press "Create my admin account"
  Then I should see "Code can't be blank"
  
Scenario: admin signup with code
  When I am on the home page
  And I follow "Admin"
  And I follow "Sign up"
  Then I should be on the adminsignup page 
  And I fill in "Name" with "Henry"
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I fill in "Password Confirmation" with "123456"
  And I fill in "Code" with "BsvKCFDT"
  And I press "Create my admin account"
  Then "henry@tamu.edu" should receive an email 
  Then I should see "Welcome to Career Closet Admin Interface! Henry"
  When I open the email with subject "Please confirm your registration (Admin)."
  When I click the first link in the email
  Then I should see "Welcome to TAMU Closet! Your admin account has now been confirmed."
  And I follow "As Admin"
  Then I am on the adminlogin page
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should see "Suits inventory"
  And I follow "Settings"
  And I should see "Update your profile"
  And I fill in "Password" with "123456"
  And I fill in "Password Confirmation" with "123456"
  And I press "Save change"
  And I should see "Your account was updated successfully"