Feature: admin use anvbar to navigate 
 
  As an admin
  So that I could quickly jump to other link
  I want to be able to use navbar

Background: suits have been added to database


  And I am on the home page



Scenario: use navbar to return to home
  When I am on the home page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the adminlogin page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the login page
  And I follow "Home"
  Then I should be on the home page


Scenario: use navbar to return to help page
  When I am on the home page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the adminlogin page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the login page
  And I follow "Home"
  Then I should be on the home page
  
Scenario: use navbar to return to adminlogin page
  When I am on the home page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the adminlogin page
  And I follow "Home"
  Then I should be on the home page
  
  When I am on the login page
  And I follow "Home"
  Then I should be on the home page  
  
