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

