require 'spec_helper'

describe Testsuite do
  def create_suite(attributes = {})
    project = Project.new
    project.stubs(Project.plan.merge({:id => 10}))

    user = User.new
    user.stubs(User.plan(:current_project => project).merge({:id => 10}))

    Testcase.make_unsaved(:project => project, :created_by => user, :edited_by => user)
  end

  it "should be valid" do
    testsuite = create_suite
    testsuite.should be_valid
  end

  def make_full_suite
    step = Teststep.make(:full)
    testcase = step.testcase
    user = testcase.created_by
    suite = Testsuite.make(:project => testcase.project, :created_by => user, :edited_by => user)
    suite.add_testcase(testcase)
    suite
  end

  it "should create a valid test run" do
    suite = make_full_suite
    suite.create_run(suite.created_by)
  end
end
