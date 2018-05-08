Feature: appointment system check
 
  As an admin and customer
  So that I make operations
  I want to manage my appointments on the website

Background: users in database
 Given the following users exist:
  |id| first_name    |  last_name  |     uin   |   phone       |     email      |   available    | email_confirmed |  password | password_confirmation | 
  |1 | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    false       |     true        |   123456  |   123456              |         
  |2 | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    true        |     true        |   123456  |   123456              |
  |3 | Henry2        |     Lin     | 123456791 |   9796823432  | henry2@tamu.edu|    false       |     true        |   123456  |   123456              |
  Given the following admins exist:
  | name      |    email       | password | password_confirmation | email_confirmed |     code    |
  | Cathy     | cathy@tamu.edu | 123456   |   123456              |      true       |   R7BhQG9a  |
  | Brick     | bk@tamu.edu    | 123456   |   123456              |      true       |   PncCz4gm  |
  Given the following appointments exist:
  | time                |   slot   | user_id |
  |2018-04-08 00:00:00  | 9:30 am  |   1     |
  |2018-04-08 00:00:00  | 9:30 am  |   3     |

Scenario: user makes and edit an appointment with time
  When I am on the login page
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see "Listing Appointments"
  And I follow "New Appointment"
  And I should see "Please select your avaliable time"
  When I change the value of the "appointment_time" to "2018-04-24"
  When I change the value of the "appointment_slot" to "9:30 am"
  Then I press "Submit"
  Then I should see "Appointment was successfully created."
  And I follow "Edit"
  When I change the value of the "appointment_time" to "2018-04-25"
  When I change the value of the "appointment_slot" to "10:30 am"
  Then I press "Submit"
  And I should see "Appointment was successfully updated."
  And I follow "Back"
  And I should see "123456790"
  And I follow "Cancel"
  And I should not see "123456790"
  
Scenario: admins manage appointments with time
  When I am on the adminlogin page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I am on the appointments page
  And I should see "Listing Appointments"
  And I should see "2018/04/08"
  
Scenario: admins manage appointments with time
  When I am on the appointments page
  When I should see "Please log in to our perform."
  
Scenario: user only can make one appointment one time
  When I am on the login page
  And I fill in "Email" with "henry@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see "Listing Appointments"
  And I follow "New Appointment"
  And I should see "Please select your avaliable time"
  When I change the value of the "appointment_time" to "2018-04-24"
  When I change the value of the "appointment_slot" to "9:30 am"
  Then I press "Submit"
  Then I should see "Appointment was successfully created."
  Then I follow "Back"
  And I follow "New Appointment"
  And I should see "Please select your avaliable time"
  When I change the value of the "appointment_time" to "2018-04-24"
  When I change the value of the "appointment_slot" to "9:30 am"
  Then I press "Submit"
  Then I should see "You can only has one appointment."
  
