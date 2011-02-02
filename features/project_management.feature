Feature: Manage Projects
  To be able to manage the test cases of many projects concurrently
  As an Administrator
  I should be able to manage my projects

  Scenario: Show project list
    Given a project exists with name: "Testproject"
    And I am logged in as user "test"
    And a project exist with name: "Some other project"
    And I go to the projects list
    Then I should see "Testproject"
    And I should see "Some other project"

  Scenario: Create project
    Given there do not exist any projects
    And I am logged in as user "test"
    And I am on the projects list
    When I follow "New Project"
    And I enter the following values
      | Name | Testproject |
    And I press "Create Project"
    Then I should see "Successfully created project."
    And the number of projects is 1

  Scenario: Cancel Project creation
    Given there do not exist any projects
    And I am logged in as user "test"
    And I am on the projects list
    When I follow "New Project"
    And I enter the following values
      | Name | Testproject |
    And I follow "cancel"
    Then the number of projects is 0

  Scenario: Project creation with invalid name
    Given there do not exist any projects
    And I am logged in as user "test"
    And I am on the projects list
    When I follow "New Project"
    And I press "Create Project"
    Then I should not see "Successfully created project."
    And I should see "can't be blank"

  Scenario: Edit Project
    Given a project exists with name: "My test project"
    And I am logged in as user "test" for that project
    And I am on the show page for that project
    When I follow "edit"
    And I enter the following values
      | Name | New project name |
    And I press "project_submit"
    Then I should see "Successfully updated project."
    And I should see "New project name"

  Scenario: Delete Project
    Given a project exists with name: "My test project"
    And I am logged in as user "test" for that project
    And I am on the show page for that project
    When I follow "delete"
    Then I should see "Successfully deleted project."

