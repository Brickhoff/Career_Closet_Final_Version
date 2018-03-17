Feature: user sign out
 
  As an user
  So that I could leave my account or change to another account
  I want to sign out to the website

Background: suits have been added to database


  And I am on the appointments page
  
Scenario: user sign out
  When I am on the appointments page
  Then "Account" should be selected for me
  And I follow "Log out"
  Then I should be on the login page