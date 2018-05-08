Feature: manage a suit
 
  As an admin
  So that I can manage suit information
  I want to create/edit/delete a suit

Background: suits in database
  Given the following suits exist:
  | appid     |     gender     | article  | size |  status   | 
  | JM123     |       F        | slim     | 28   | Checkout  | 

Scenario: destroy a suit(sad path)
  When I am on the suits page
  Then I should see "Suits inventory"
  Then I should see "JM123"
  And I follow "Delete"
  Then I should see "JM123"
  And I should see "Suit cannnot be deleted, Please return the suit."

Scenario: manage a suit
  When I am on the suits page
  Then I should see "Suits inventory"
  And I follow "Add new suits"
  And I fill in "App. ID" with "ABC 78"
  And I select "M" from "Gender"
  And I fill in "Size" with "6"
  And I fill in "Article" with "A fashion suit."
  And I press "Submit"
  Then I should see "Showing selected Suit"
  And I follow "Edit"
  And I fill in "Size" with "10"
  And I press "Submit"
  Then I should see "Showing selected Suit"
  And I follow "Delete"
  Then I should see "Suits inventory"
  
Scenario: manage a suit(sad path)
  When I am on the suits page
  Then I should see "Suits inventory"
  And I follow "Add new suits"
  And I fill in "App. ID" with "ABC 78"
  And I select "M" from "Gender"
  And I fill in "Size" with "6"
  And I fill in "Article" with " "
  And I press "Submit"
  Then I should see "Article can't be blank"



  