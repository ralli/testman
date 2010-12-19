Feature: To be able to manage the test cases of many projects concurrently
As an Administrator
I should be able to manage my projects

Scenario: Show project list
Given there are projects named Testproject, Some other project
And I go to the projects list
Then I should see "Testproject"
And I should see "Some other project"
