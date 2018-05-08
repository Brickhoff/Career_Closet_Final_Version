Feature: History page
  
  As an admin
  So that I go to history page
  I want to manage the history of career closet
  
Background: histories in database
  Given the following histories exist:
  |  suit_id   |  user_id      |     checkOutTime        |   expectReturnTime         |     returnTime          |
  |     1      |      1        | 2018-04-17 21:58:59 UTC |   2018-04-20 21:58:59 UTC  | 2018-04-20 21:58:59 UTC |               
  |     2      |      2        | 2018-04-3 21:58:59 UTC  |   2018-04-13 21:58:59 UTC  | 2018-04-17 21:58:59 UTC |  
  
  Given the following admins exist:
  | name      |    email       | password | password_confirmation | email_confirmed |     code    |
  | Cathy     | cathy@tamu.edu | 123456   |   123456              |      true       |   R7BhQG9a  |
  | Brick     | bk@tamu.edu    | 123456   |   123456              |      true       |   PncCz4gm  |
  
  Given the following suits exist:
  | appid       |     gender     | article  | size |  status   | 
  | goodboy     |       F        | slim     | 28   | Checkout  |
  | badgirl     |       M        | fit      | 32   | Checkout  |
  | sexy        |       F        | slim     | 34   | Available |
  
  Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    |  password | password_confirmation | email_confirmed |
  | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    ture       | 123456    |   123456              |     true        |
  | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    ture        | 123456    |   123456              |     true        |
  | Brickhoff     |     Wu      | 345678901 |   1234567898  | bri@tamu.edu   |    true        | 123456    |   123456              |     true        |

Scenario: admin login, create history, edit history, delete history
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  And I follow "History"
  And I should see "Histories"
  And I follow "New History"
  Then I should see "New History"
  And I select "sexy" from "history[suit_id]"
  And I select "345678901" from "history[user_id]"
  And I select "2018" from "history_checkOutTime_1i"
  And I select "April" from "history_checkOutTime_2i"
  And I select "13" from "history_checkOutTime_3i"
  And I select "03" from "history_checkOutTime_4i"
  And I select "03" from "history_checkOutTime_5i"
  And I select "2018" from "history_expectReturnTime_1i"
  And I select "April" from "history_expectReturnTime_2i"
  And I select "20" from "history_expectReturnTime_3i"
  And I select "03" from "history_expectReturnTime_4i"
  And I select "03" from "history_expectReturnTime_5i"
  And I select "2018" from "history_returnTime_1i"
  And I select "April" from "history_returnTime_2i"
  And I select "21" from "history_returnTime_3i"
  And I select "03" from "history_returnTime_4i"
  And I select "03" from "history_returnTime_5i"
  And I press "Create History"
  Then I should see "History was successfully created."
  And I follow "Edit"
  Then I should see "Editing History"
  And I select "goodboy" from "history[suit_id]"
  And I select "123456789" from "history[user_id]"
  And I select "2018" from "history_returnTime_1i"
  And I select "April" from "history_returnTime_2i"
  And I select "21" from "history_returnTime_3i"
  And I select "03" from "history_returnTime_4i"
  And I select "03" from "history_returnTime_5i"
  And I press "Update History"
  Then I should see "History was successfully updated."
  And I follow "Delete"
  Then I am on the histories page
  
Scenario: admin login, create history, edit history, delete history
  When I am on the home page
  And I follow "Admin"
  Then I should be on the adminlogin page
  And I fill in "Email" with "bk@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  Then I should be on the suits page
  And I follow "History"
  And I should see "Histories"
  And I follow "App. ID"