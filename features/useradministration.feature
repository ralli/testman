Feature: To control access to the system
As a System administrator
I would like to manage the user base and the user permissions

  Scenario: Show user list
    Given a user exists with login: "userlogin", password: "test123", password_confirmation: "test123", first_name: "Harry", last_name: "Hirsch"
    And I am logged in as administrator "admin"
    When I go to the users page
    Then I should see "userlogin"
    And I should see "Harry"
    And I should see "Hirsch"

  Scenario: Show user list if not logged in
    Given a user exists with login: "userlogin", password: "test123", password_confirmation: "test123", first_name: "Harry", last_name: "Hirsch"
    When I go to the users page
    Then I should see "Sorry, you are not allowed to access that page."

