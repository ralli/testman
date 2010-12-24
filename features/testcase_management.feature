Feature: Managing Testcases
  In order to be able to track test executions
  As a logged in User
  I should be able to create, delete and modify Testcases

Scenario: Show Testcases
  Given there exists an active Project
  And I am logged in as User "test"
  And there exists a Testcase named "My first Test case"
  And I am on the list of test cases
  Then I should see "My first Test case"

Scenario: Create Testcase
  Given there exists an active Project
  And I am logged in as User "test"
  And I am on the list of test cases
  And I follow "New Testcase"
  And I enter the following values
    | Name | My Test case |
    | Description | This is the description |
  And I press "testcase_submit"
  Then I should see "My Test case"
  And I should see "Your Test case has been successfully created"