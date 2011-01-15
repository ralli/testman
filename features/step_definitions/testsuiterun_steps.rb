Given /^a testsuiterun with (\d+) testcases and (\d+) teststeps per testcase exists$/ do |testcasecount, teststepcount|
  project   = Project.first || Project.make
  user      = User.make(:current_project => project)
  testcases = []
  testcasecount.to_i.times do
    testcase = Testcase.make(:project => project, :created_by => user, :edited_by => user)
    teststepcount.to_i.times do
      Teststep.make(:testcase => testcase)
    end
    testcases << testcase
  end  
  testsuite = Testsuite.make(:project => project, :created_by => user, :edited_by => user)
  testcases.each do |testcase|
    testsuite.add_testcase(testcase)
  end
  testsuite = Testsuite.find(testsuite.id)
  testsuite.create_run(user)
end
