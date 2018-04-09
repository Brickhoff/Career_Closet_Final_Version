Feature: manage a suit
 
  As an admin
  So that I can manage suit information
  I want to create/edit/delete a suit


Scenario: manage a suit
  When I am on the suits page
  Then I should see "Suits inventory"
  And I follow "Add new suits"
  And I fill in "App. ID" with "ABC 78"
  And I select "M" from "Gender"
  And I fill in "Size" with "6"
  And I fill in "Article" with "A fashion suit."
  And I press "Create Suit"
  Then I should see "Showing selected Suit"
  And I follow "Edit"
  And I fill in "Size" with "10"
  And I press "Update Suit"
  Then I should see "Showing selected Suit"
  And I follow "Delete"
  Then I should see "Suits inventory"
  