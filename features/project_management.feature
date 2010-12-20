Feature: Manage Projects
  To be able to manage the test cases of many projects concurrently
  As an Administrator
  I should be able to manage my projects

  Scenario: Show project list
    Given there are projects named Testproject, Some other project
    And I go to the projects list
    Then I should see "Testproject"
    And I should see "Some other project"

  Scenario: Create project
    Given there do not exist any projects
    And I am logged in as User "test"
    And I am on the projects list
    When I follow "New Project"
    And I enter the following values
      | Name | Testproject |
    And I press "Create Project"
    Then I should see "Successfully created project."
    And the number of projects is 1

  Scenario: Cancel Project creation
    Given there do not exist any projects
    And I am logged in as User "test"
    And I am on the projects list
    When I follow "New Project"
    And I enter the following values
      | Name | Testproject |
    And I follow "Back to List"
    Then the number of projects is 0

  Scenario: Project creation with invalid name
    Given there do not exist any projects
    And I am logged in as User "test"
    And I am on the projects list
    When I follow "New Project"
    And I press "Create Project"
    Then I should not see "Successfully created project."
    And I should see "can't be blank"
