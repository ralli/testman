Feature: Run a test suite
  To be able to help the testers to execute their test suites and to record the results autmatically to
  be able to do reporting to have a tool to improve software development process
  As a tester
  I would like to run test suites and test steps

  Scenario: Start running a test suite from the show testsuite page
    Given a project exists
    And I am logged in as user "test" for that project
    And a testcase exists with project: the project
    And a testsuite exists with project: the project, created_by: the user, edited_by: the user
    And a testsuite entry exists with testsuite: the testsuite, testcase: the testcase
    And a teststep exists with testcase: the testcase
    And I am on the show page for the testsuite
    When I follow "run_testsuite"
    Then 1 testsuiteruns should exist
    And 1 testcaseruns should exist
    And 1 teststepruns should exist
    And 1 testcaselogs should exist with status: "new", result: "unknown"

  Scenario: Start running a test suite from the list of test suites
    Given a project exists
    And I am logged in as user "test" for that project
    And a testcase exists with project: the project
    And a testsuite exists with project: the project, created_by: the user, edited_by: the user
    And a testsuite entry exists with testsuite: the testsuite, testcase: the testcase
    And a teststep exists with testcase: the testcase
    And I am on page "/testsuites"
    When I follow "run_testsuite"
    Then 1 testsuiteruns should exist
    And 1 testcaseruns should exist
    And 1 teststepruns should exist
    And 1 testcaselogs should exist with status: "new", result: "unknown"

  Scenario: Run a step of a test suite with one testcase and one teststep successfully
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuiterun with 1 testcases and 1 teststeps per testcase exists
    And I am on page "/testsuiteruns"
    When I follow "show_testsuiterun"
    And I follow "step_ok"
    Then 1 teststepruns should exist with result: "ok", status: "ended"
    And 1 testcaseruns should exist with result: "ok", status: "ended"
    And 1 testsuiteruns should exist with result: "ok", status: "ended"
    And 1 testcaselogs should exist with status: "ended", result: "ok"

  Scenario: Run a step of a test suite with one testcase and one teststep failing
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuiterun with 1 testcases and 1 teststeps per testcase exists
    And I am on page "/testsuiteruns"
    When I follow "show_testsuiterun"
    And I follow "step_failure"
    And I press "save"
    Then 1 teststepruns should exist with result: "failed", status: "ended"
    And 1 testcaseruns should exist with result: "failed", status: "ended"
    And 1 testsuiteruns should exist with result: "failed", status: "ended"
    And 1 testcaselogs should exist with status: "ended", result: "failed"

  Scenario: Do not show step links if testrun ended
    Given a project exists
    And I am logged in as user "test" for that project
    And a full testsuiterun exists with status: "ended", result: "ok"
    When I am on the show page for the testsuiterun
    Then I should not see "Step (Ok)"
    Then I should not see "Step (Failure)"

  Scenario: Show step links if testrun running
    Given a project exists
    And I am logged in as user "test" for that project
    And a full testsuiterun exists with status: "running", result: "unknown"
    When I am on the show page for the testsuiterun
    Then I should see "Step (Ok)"
    Then I should see "Step (Failure)"

  Scenario: Show all teststeps of a testsuite run
    Given a project exists
    And I am logged in as user "test" for that project
    And a full testsuiterun exists with status: "running", result: "unknown", show_mode: "current"
    When I am on the show page for the testsuiterun
    And I follow "show_all"
    Then I should see "Show only current"

  Scenario: Show all teststeps of a testsuite run
    Given a project exists
    And I am logged in as user "test" for that project
    And a full testsuiterun exists with status: "running", result: "unknown", show_mode: "all"
    When I am on the show page for the testsuiterun
    And I follow "show_current"
    Then I should see "Show all testcases"

  Scenario: Filter testsuiteruns by status
    Given a project exists
    And I am logged in as user "test" for that project
    And a testsuiterun with 1 testcases and 1 teststeps per testcase exists
    And I am on page "/testsuiteruns"
    When I select "Unknown"
    And I press "testsuiterun_search_submit"
    Then I should see "Search (one match)"

