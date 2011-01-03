Feature: Manage Testsuites
  In order to not need to specify which test cases to run each time I test certain parts of the SUT
  As a test manager
  I would like to be able to manage test suites

  Scenario: List Test Suites
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuite exists with name: "My test suite", project: that project
    And a testsuite exists with name: "My second suite", project: that project
    When I go to page "/testsuites"
    Then I should see "My test suite"
    And I should see "My second suite"

  Scenario: Create Test Suite
    Given a project exists
    And I am logged in as user "test" for that project
    And I am on the page "/testsuites"
    When I follow "new_testsuite"
    And I enter the following values
      | Name        | My test suite  |
      | Description | My description |
    And I press "testsuite_submit"
    Then I should see "Testsuite successfully created."
    And I should see "My test suite"
    And I should see "My description"

  Scenario: Cancel Test Suite creation
    Given a project exists
    And I am logged in as user "test" for that project
    And I am on the page "/testsuites"
    When I follow "new_testsuite"
    And I enter the following values
      | Name        | My test suite  |
      | Description | My description |
    And I follow "back"
    Then 0 testsuites exist
    And I should see "Testsuites"

  Scenario: Edit Test suite
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuite exists with project: the project
    And I am on the page "/testsuites"
    When I follow "edit_testsuite"
    And I enter the following values
      | Name        | My test suite  |
      | Description | My description |
    And I press "testsuite_submit"
    Then I should see "Successfully saved Testsuite."
    And I should see "My test suite"
    And I should see "My description"

  Scenario: Delete Test Suite
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuite exists with project: the project
    When I go to the page "/testsuites"
    And I follow "delete_testsuite"
    Then I should see "Successfully deleted Testsuite."
    And 0 testsuites should exist

  Scenario: Add Testcase to Testsuite
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuite exists with project: the project
    And a testcase exists with project: the project
    And I am on the show page for the testsuite
    When I follow "add_testcase"
    And I follow "add_testcase"
    Then I should see "Successfully added Testcase"
    And a testsuite entry should exist

  Scenario: Delete Testcase from Testsuite
    Given an project exists
    And I am logged in as user "test" for that project
    And a testsuite exists with project: the project
    And a testcase exists with project: the project
    And a testsuite entry exists with testsuite: the testsuite, testcase: the testcase
    And I am on the show page for the testsuite
    When I follow "remove_testcase"
    Then I should see "Successfully removed the Testcase from the Testsuite"
    And 0 testsuite entries should exist
