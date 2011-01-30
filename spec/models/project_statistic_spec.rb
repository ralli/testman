require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectStatistic do
  context "when querying the database" do
    before :all do
      @project   = Project.make
      @user      = User.make(:current_project => @project)
      @testcase1 = Testcase.make(:project => @project, :created_by => @user, :edited_by => @user)
      @testcase2 = Testcase.make(:project => @project, :created_by => @user, :edited_by => @user)
      @testcase1.teststeps.make
      @testcase2.teststeps.make

      @testsuite1 = Testsuite.make(:project => @project, :created_by => @user, :edited_by => @user)
      @testsuite2 = Testsuite.make(:project => @project, :created_by => @user, :edited_by => @user)
      @testsuite1.testsuite_entries.create(:testcase => @testcase1)
      @testsuite1.testsuite_entries.create(:testcase => @testcase2)
      @testsuite2.testsuite_entries.create(:testcase => @testcase1)
      @testsuite2.testsuite_entries.create(:testcase => @testcase2)
      @testsuiterun1 = @testsuite1.create_run(@user)
      @testsuiterun2 = @testsuite2.create_run(@user)
      @testsuiterun1.set_all(@user, 'ok')
    end

    before :each do
      @statistics = ProjectStatistic.new(@project)
    end

    it "should return a valid testsuitecount" do
      @statistics.testsuite_count.should == 2
    end

    it "should return a valid testcasecount" do
      @statistics.testcase_count.should == 2
    end

    it "should return a valid teststepcount" do
      @statistics.teststep_count.should == 2
    end

    it "should return valid testsuite grouped by status" do
      @statistics.testsuiterun_status_groups.should == {"ended" => 1, "new" => 1}
    end

    it "should return valid testsuite grouped by result" do
      @statistics.testsuiterun_result_groups.should == {"ok" => 1, "unknown" => 1}
    end

    it "should return valid testcases grouped by status" do
      @statistics.testcaserun_status_groups.should == {"ended" => 2, "new" => 2}
    end

    it "should return valid testcases grouped by result" do
      @statistics.testcaserun_result_groups.should == {"unknown" => 2, "ok" => 2}
    end

    it "should return valid teststeps grouped by status" do
      @statistics.teststeprun_status_groups.should == {"ended" => 2, "new" => 2}
    end

    it "should return valid teststeps grouped by result" do
      @statistics.teststeprun_result_groups.should == {"unknown" => 2, "ok" => 2}
    end
  end

  it "should query the testsuite groups for statuses once if called multiple times" do
    testsuiteruns = stub(:group => [])
    project       = mock()
    project.expects(:testsuiteruns).returns(testsuiteruns)
    statistics = ProjectStatistic.new(project)
    statistics.testsuiterun_status_groups
    statistics.testsuiterun_status_groups
  end

  it "should query the testsuite groups for results once if called multiple times" do
    testsuiteruns = stub(:group => [])
    project       = mock()
    project.expects(:testsuiteruns).returns(testsuiteruns)
    statistics = ProjectStatistic.new(project)
    statistics.testsuiterun_result_groups
    statistics.testsuiterun_result_groups
  end

  it "should query the testcaserun groups for statuses once if called multiple times" do
    testcaseruns = stub(:group => [])
    project      = mock()
    project.expects(:testcaseruns).returns(testcaseruns)
    statistics = ProjectStatistic.new(project)
    statistics.testcaserun_status_groups
    statistics.testcaserun_status_groups
  end

  it "should query the testcaserun groups for results once if called multiple times" do
    testcaseruns = stub(:group => [])
    project      = mock()
    project.expects(:testcaseruns).returns(testcaseruns)
    statistics = ProjectStatistic.new(project)
    statistics.testcaserun_result_groups
    statistics.testcaserun_result_groups
  end

  it "should query the teststeprun groups for statuses once if called multiple times" do
    teststepruns = stub()
    teststepruns.stubs(:joins).returns(stub(:group => []))
    project = mock()
    project.expects(:testcaseruns).returns(teststepruns)
    statistics = ProjectStatistic.new(project)
    statistics.teststeprun_status_groups
    statistics.teststeprun_status_groups
  end

  it "should query the teststeprun groups for results once if called multiple times" do
    teststepruns = stub()
    teststepruns.stubs(:joins).returns(stub(:group => []))
    project = mock()
    project.expects(:testcaseruns).returns(teststepruns)
    statistics = ProjectStatistic.new(project)
    statistics.teststeprun_result_groups
    statistics.teststeprun_result_groups
  end
end
