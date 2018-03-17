Feature: admin use footer to navigate 
 
  As an admin
  So that I could quickly jump to other link
  I want to be able to use footer

Background: suits have been added to database


  And I am on the home page



Scenario: use footer to return to about
  When I am on the home page
  And I follow "About"
  Then I should be on the about page
  
  When I am on the adminlogin page
  And I follow "About"
  Then I should be on the about page
  
  When I am on the login page
  And I follow "About"
  Then I should be on the about page


Scenario: use footer to return to help page
  When I am on the home page
  And I follow "Contact"
  Then I should be on the contact page
  
  When I am on the adminlogin page
  And I follow "Contact"
  Then I should be on the contact page
  
  When I am on the login page
  And I follow "Contact"
  Then I should be on the contact page
  

# to be continued

