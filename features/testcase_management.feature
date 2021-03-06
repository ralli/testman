Feature: Managing Testcases
  In order to be able to track test executions
  As a logged in User
  I should be able to create, delete and modify Testcases

  Scenario: Show Testcases
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And a testcase exists with name: "My first Test case", project: that project
    And I am on the list of test cases
    Then I should see "My first Test case"

  Scenario: Create testcase
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And I am on the list of test cases
    And I follow "New Testcase"
    And I enter the following values
      | Name        | My Test case            |
      | Description | This is the description |
    And I press "testcase_submit"
    Then I should see "My Test case"
    And I should see "The testcase has been successfully created."

  Scenario: Create testcase version
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And a testcase exists with name: "My testcase", project: the project
    And I am on the show page for the testcase
    And I follow "create_version"
    Then I should see "Successfully created a new version."
    And I should see "My testcase"
    And 1 testcases should exist with version: "2"

  Scenario: Cancel adding Testcase Attachment
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And a testcase exists with name: "My testcase", project: the project
    And I am on the show page for the testcase
    And I follow "add_attachment"
    When I follow "cancel"
    Then I should see "My testcase"

  Scenario: Search Testcase
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And a testcase exists with name: "Wonderful testcase", project: the project
    And I am on the testcases page
    And I enter the following values
      | search | Wonderful |
    And I press "Search"
    Then I should see "Wonderful testcase"

  Scenario: List Testcases by Tag
    Given a project exists with name: "Test project"
    And I am logged in as user "test" for that project
    And a testcase exists with name: "Wonderful testcase", project: the project, tag_list: "smalltalk"
    And I am on the testcases page
    When I follow "smalltalk"
    Then I should see "Wonderful testcase"

