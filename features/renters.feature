Feature: rental system check
 
  As an admin
  So that I make operations
  I want to manage my rental record on the website
  
Background: users in database
  Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    |  password | password_confirmation | 
  | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    false       | 123456    |   123456              |         
  | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    true        | 123456    |   123456              |

  Given the following suits exist:
  | appid     |     gender     | article  | size |  status   | 
  | JM123     |       G        | slim     | 28   | Checkout  | 
  | JM143     |       M        | slim     | 25   | Available | 

  Given the following renters exist:
  | checkOutTime              | expectReturnTime            | returnTime  | status  |  user_id   | suit_id |
  | 2018-04-08 19:00:00 -0500 | 2018-04-18 19:00:00 -0500   |             | Checkou |      1     |    1    |

  Given the following histories exist:
  |  suit_id   |  user_id      |     checkOutTime        |   expectReturnTime         |     returnTime          |
  |      1     |   1           | 2018-04-17 21:58:59 UTC |   2018-04-20 21:58:59 UTC  | 2018-04-20 21:58:59 UTC |               
  |      2     |   2           | 2018-04-3 21:58:59 UTC  |   2018-04-13 21:58:59 UTC  | 2018-04-17 21:58:59 UTC | 

Scenario: create a rental record (sad path that suit is not available)
  When I am on the renters page
  Then I should see "Suit App. ID:"
  Then I follow "Rent a suit"
  And I should see "UIN of costumer:"
  And I select "123456790" from "UIN of costumer:"
  And I select "JM123" from "App. ID"
  Then I press "Make a rent"
  And I should see "The suit is not available."
  
Scenario: create a rental record (sad path customer holds a suit)
  When I am on the renters page
  Then I should see "Suit App. ID:"
  Then I follow "Rent a suit"
  And I should see "UIN of costumer:"
  And I select "123456789" from "UIN of costumer:"
  And I select "JM143" from "App. ID"
  Then I press "Make a rent"
  And I should see "Suit is checked out."
  
Scenario: create a rental record (sad path Please select a customer.)
  When I am on the renters page
  Then I should see "Suit App. ID:"
  Then I follow "Rent a suit"
  And I should see "UIN of costumer:"
  And I select "JM143" from "App. ID"
  Then I press "Make a rent"
  And I should see "Please select a customer."

  
Scenario: create a rental record
  When I am on the renters page
  Then I should see "Suit App. ID:"
  Then I follow "Rent a suit"
  And I should see "UIN of costumer:"
  And I select "123456790" from "UIN of costumer:"
  And I select "JM143" from "App. ID"
  Then I press "Make a rent"
  And I am on the renters page

Scenario: create a rental record
  When I am on the renters page
  Then I should see "Suit App. ID:"
  Then I follow "Rent a suit"
  Then I follow "Back to Rent System"
  And I am on the renters page
  
Scenario: Show a rental record
  When I am on the renters page
  Then I follow "123456789"
  And I should see "Customer name:"
  And I should see "Cathy"
  And I follow "Edit"
  And I should see "123456789"
  And I press "Edit"

Scenario: Remind customer to return a suit
  When I am on the renters page
  Then I follow "123456789"
  And I should see "Cathy"
  And I press "Remind cutomer to return the suit."
  And I am on the renters page
  
Scenario: Delete a rental record
  When I am on the renters page
  Then I follow "123456789"
  And I should see "Cathy"
  And I should see "Delete"
  And I follow "Delete"
  And I am on the renters page
