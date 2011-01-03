Feature: Manage Test Steps
  In Order to be able to be able to describe precisely how to execute a certain test step
  As a Testcase Manager
  I would like to add edit and delete testcases and change their order

  Scenario: Create Test Step
    Given a project exists
    And I am logged in as user "test" for that project
    And a testcase exists with project: that project
    When I go to the show page for that testcase
    And I follow "new_teststep"
    And I enter the following values
      | Step            | My step description |
      | Expected result | My expected result  |
    And I press "teststep_submit"
    Then I should see "Successfully created test step."
    And I should see "My step description"
    And I should see "My expected result"

  Scenario: Edit Test Step
    Given a project exists
    And I am logged in as user "test" for that project
    And a testcase exists with project: that project
    And a teststep exists with testcase: that testcase
    And I go to the show page for that testcase
    And I follow "edit_teststep"
    And I enter the following values
      | Step            | My step description |
      | Expected result | My expected result  |
    And I press "teststep_submit"
    Then I should see "Successfully updated test step."
    And I should see "My step description"
    And I should see "My expected result"

  Scenario: Delete Test Step
    Given a project exists
    And I am logged in as user "test" for that project
    And a testcase exists with project: that project
    And a teststep exists with testcase: that testcase
    And I go to the show page for that testcase
    And I follow "delete_teststep"
    Then I should see "Successfully deleted test step."
