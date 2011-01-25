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

  context "when stepping" do
    it "should be ended even if no teststep run exists" do
      @testcase = Testcase.new
      @testcase.stubs(Testcase.plan)
      @testcaserun = Testcaserun.new
      @user = User.make_unsaved
      @testcaserun = Testcaserun.make_unsaved(:status => 'new', :result => 'unknown', :testcase => @testcase, :created_by => @user, :edited_by => @user)
      @testcaserun.expects(:save!)
      arr = Array.new
      arr.expects(:create!)
      @testcaserun.stubs(:testcaselogs => arr)
      @testcaserun.step(@user, 'ok')
      @testcaserun.status.should== 'ended'
      @testcaserun.result.should== 'ok'
    end
    
    it "just should step the first open teststep if there is another open teststep left" do
      @testcaserun = Testcaserun.make_unsaved(:status => 'new', :result => 'unknown')
      @teststep = stub()
      @teststep.stubs(:step)
      @testcaserun.stubs(:nextstep => @teststep)
      @testcaserun.step('bla', 'ok')
      @testcaserun.status.should== 'new'
      @testcaserun.result.should== 'unknown'
    end
    
    it "should be ended if the last teststep ended" do
      @testcaserun = Testcaserun.make_unsaved(:status => 'new', :result => 'unknown')
      @teststep = stub()
      @teststep.stubs(:step)
      @testcaserun.stubs(:nextstep => @teststep)
      @testcaserun.stubs(:nextstep => nil)
      @testcaserun.expects(:update_status)
      @testcaserun.step('bla', 'ok')
    end

    it "should just return nil if already ended" do
      @testcaserun = Testcaserun.make_unsaved(:status => 'ended')
      @testcaserun.step('bla', 'ok').should be_nil
    end
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
