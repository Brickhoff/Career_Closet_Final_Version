Feature: back to closet from user profile
 
  As an user
  So that I back to closet
  I want to change my website

Background: suits have been added to database



Scenario: back to closet from user profile
  When I am on the users page
  And I follow "Back to closet"
  Then I should be on the suits page 
  And I follow "Back to Homepage"
  Then I should be on the home page