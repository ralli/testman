Feature: Login and Logoff the system
  In order to be able to document all test executions
  A User
  Should be able to log into the system

  Scenario: User not logged in
    Given I am on the home page
    Then I should see "Login"
    And I should see "Register"

  Scenario: Trying to access a page not being logged in
    Given I am on the home page
    When I go to page "/testcases"
    Then I should see "Sorry, you are not allowed to access that page."

  Scenario: Trying to log in while being logged in
    Given a project exists
    And I am logged in as user "test" for that project
    When I go to page "/login"
    Then I should see "You must be logged out to access this page"

  Scenario: Trying to edit a user while not being logged in
    Given a user exists
    When I go to the show page for the user
    Then I should see "You must be logged in to access this page"

  Scenario: Successfully log into the System
    Given a user exists with login: "test", password: "test123", first_name: "Horst", last_name: "Hrubesch"
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

  Scenario: Logged in as user with active project
    Given a project exists with name: "Hase"
    And I am logged in as user "test" for that project
    And I am on the home page
    Then I should see "Current Project: Hase"

  Scenario: Logged in as user without active project
    Given I am logged in as user "test"
    And I am on the home page
    Then I should see "Choose current project"
