Feature: appointment system check
 
  As an admin and customer
  So that I make operations
  I want to manage my appointments on the website

Background: users in database
 Given the following users exist:
  | first_name    |  last_name  |     uin   |   phone       |     email      |   available    |  password | password_confirmation | 
  | Cathy         |     Zhang   | 123456789 |   9796863432  | cathy@tamu.edu |    false       | 123456    |   123456              |         
  | Henry         |     Lin     | 123456790 |   9796823432  | henry@tamu.edu |    true        | 123456    |   123456              |
  | Henry2        |     Lin     | 123456791 |   9796823432  | henry2@tamu.edu|    true        | 123456    |   123456              |
  Given the following admins exist:
  | name      |    email       | password | password_confirmation | 
  | Cathy     | cathy@tamu.edu | 123456   |   123456              |         
  | Brick     | bk@tamu.edu    | 123456   |   123456              |
  Given the following appointments exist:
  | time                      |        appointments                   | user_id |
  |2018-04-08 19:00:00 -0500  |      2018-04-08 19:00:00 -0500        |   2     |
  |2018-04-08 19:00:00 -0500  |      2018-04-08 19:00:00 -0500        |   3     |

Scenario: user makes and edit an appointment with time
  When I am on the login page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I should see "Listing Appointments"
  And I follow "New Appointment"
  And I select "2018" from "appointment_time_1i"
  And I select "April" from "appointment_time_2i"
  And I select "12" from "appointment_time_3i"
  And I select "03" from "appointment_time_4i"
  And I select "03" from "appointment_time_5i"
  And I should see "New Appointment"
  And I press "Create Appointment"
  Then I should see "Appointment was successfully created."
  And I follow "Edit"
  And I select "2018" from "appointment_time_1i"
  And I select "May" from "appointment_time_2i"
  And I select "12" from "appointment_time_3i"
  And I select "03" from "appointment_time_4i"
  And I select "03" from "appointment_time_5i"
  And I press "Update Appointment"
  And I should see "Appointment was successfully updated."
  And I follow "Back"
  And I should see "123456789"
  And I follow "Destroy"
  And I should not see "123456789"
  
Scenario: admins manage appointments with time
  When I am on the adminlogin page
  And I fill in "Email" with "cathy@tamu.edu"
  And I fill in "Password" with "123456"
  And I press "Log in"
  And I am on the appointments page
  And I should see "Listing Appointments"
  And I should see "123456790"
  
Scenario: admins manage appointments with time
  When I am on the appointments page
  When I should see "You must be logged in to perform that action"