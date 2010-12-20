Feature: To be able to work with the system
  As a User
  I would like to register myself at the system

  Scenario: User registration
    Given there exists no User
    And I am on the home page
    When I follow "Register"
    And I enter the following values
      | Login                 | test             |
      | Password              | test123          |
      | Password confirmation | test123          |
      | Email                 | noreply@test.com |
      | First name            | Horst            |
      | Last name             | Hrubesch         |
    And I press "Save"
    Then I should see "Successfully registered."
    And there exists 1 User.

  Scenario: Editing the profile
    Given I am logged in as User "test"
    And I am on the home page
    And I follow "Edit Profile"
    Then I should see "Edit Profile"