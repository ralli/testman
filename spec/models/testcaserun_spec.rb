require 'spec_helper'

describe Testcaserun do
  def make_valid_testrun(attributes = {})
    project = Project.new
    project.stubs(Project.plan)
    user = User.new
    user.stubs(User.plan(:current_project => project))
    testcase = Testcase.new
    testcase.stubs({:edited_by => user, :created_by => user, :project => project}.merge(Testcase.plan))
    testsuite = Testsuite.new    
    testsuite.stubs({:edited_by => user, :created_by => user, :project => project, :testcases => [testcase]}.merge(Testsuite.plan))
    tsrun = Testsuiterun.new
    run = Testcaserun.make_unsaved({:created_by => user, :edited_by => user, :testcase => testcase, :position => 1, :testsuiterun => tsrun}.merge(Testcaserun.plan).merge(attributes))
    tsrun.stubs({:created_by => user, :edited_by => user, :testsuite => testsuite, :testcaseruns => [run]}.merge(Testsuiterun.plan))
    run
  end

  context "when validating" do
    it "should be valid" do
      run = make_valid_testrun
      run.should be_valid
    end

    it "should have a status" do
      run = make_valid_testrun(:status => nil)
      run.should_not be_valid
    end

    it "should have a result" do
      run = make_valid_testrun(:result => nil)
      run.should_not be_valid
    end

    it "should have a valid status" do
      run = make_valid_testrun(:status => 'hase')
      run.should_not be_valid
    end

    it "should have a valid result" do
      run = make_valid_testrun(:result => 'hase')
      run.should_not be_valid
    end

    it "should belong to a testcase" do
      run = make_valid_testrun(:testcase => nil)
      run.should_not be_valid
    end

    it "should be valid without a testsuite run" do
      run = make_valid_testrun(:testsuiterun => nil)
      run.should be_valid
    end

    it "should be created by a user" do
      run = make_valid_testrun(:created_by => nil)
      run.should_not be_valid
    end

    it "should be edited by a user" do
      run = make_valid_testrun(:edited_by => nil)
      run.should_not be_valid
    end
  end  
end
