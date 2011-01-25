require 'spec_helper'

describe Testsuiterun do
  describe "when validating" do
    def make_valid_testrun(attributes = {})
      project = Project.new
      project.stubs(Project.plan)
      user = User.new
      user.stubs(User.plan(:current_project => project))
      testsuite = Testsuite.new
      testsuite.stubs(:edited_by => user, :created_by => user, :project => project)
      run = Testsuiterun.make_unsaved({:testsuite => testsuite, :created_by => user, :edited_by => user}.merge(attributes))
    end
  
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

    it "should belong to a test suite" do
      run = make_valid_testrun(:testsuite => nil)
      run.should_not be_valid
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

  describe "when stepping" do
    it "should update the run even if no testcase run is presend" do
      run = Testsuiterun.make_unsaved(:status => 'new', :result => 'unknown')
      run.stubs(:nextcase => nil)
      arg = { :edited_by => 'user', :status => 'ended', :result => 'ok' }
      run.expects(:update_attributes!).with(arg)
      run.step('user', 'ok')
    end

    it "should not update the run if already ended" do
      run = Testsuiterun.make_unsaved(:status => 'ended', :result => 'ok')
      run.nextcase.should be_nil
      run.next?.should be_false
      run.step?.should be_false
    end

  end
end
