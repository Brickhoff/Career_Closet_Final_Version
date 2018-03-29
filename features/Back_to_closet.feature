Feature: Suits page: create new suit and back to rent system
 
  As an admin
  So that I back to closet
  I want to change my website

Background: suits have been added to database



Scenario: back to closet from suits system
  When I am on the suits page
  And I follow "Back to Homepage"
  Then I should be on the home page

Scenario: add new closet in suits system
  When I am on the suits page
  And I follow "Add new suits"
  Then I should be on the suits new page
  And I should see "Create a new suit"
  And I fill in "App. ID" with "M1234"
  And I fill in "Gender" with "M"
  And I fill in "Article" with "Genreral"
  And I fill in "Size" with "XL"
  Then I press "Create Suit"
  #And I should see "M1234"
  #after finish association, we should continue on this part.