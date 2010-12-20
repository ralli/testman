Feature: Login and Logoff the system
  In order to be able to document all test executions
  A User
  Should be able to log into the system

  Scenario: User not logged in
    Given I am on the home page
    Then I should see "Login"
    And I should see "Register"

  Scenario: Successfully log into the System
    Given there exists a User with login "test" and password "test123" and email "test@test.com" and first name "Horst" and last name "Hrubesch"
    And there is no user logged in
    And I am on the home page
    And I follow "Login"
    And I enter the following values
      | Login    | test    |
      | Password | test123 |
    And I press "Login"
    Then I should see "Welcome"
    And I should see "Horst"
    And I should see "Hrubesch"
    And I should see "Logout"
    And I should see "Edit Profile"
