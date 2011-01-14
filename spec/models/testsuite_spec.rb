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
    project = Project.make
    user = User.make(:current_project => project)
    testcase = Testcase.make(:project => project, :created_by => user, :edited_by => user)
    teststep = Teststep.make(:testcase => testcase)
    testsuite = Testsuite.make(:project => project, :created_by => user, :edited_by => user)
    testsuite.testsuite_entries.create(:testcase => testcase)
    Testsuite.find(testsuite.id)
  end

  it "should create a valid test run" do
    suite = make_full_suite
    suite.create_run(suite.created_by)
  end

  describe "when creating a new version" do
    before :all do
      @project = Project.make
      @user = User.make(:current_project => @project)
      @testcase = Testcase.make(:project => @project, :created_by => @user, :edited_by => @user)
      @teststep = @testcase.teststeps.make
      @original = Testsuite.make(:project => @project, :created_by => @user, :edited_by => @user)
      @original.testsuite_entries.create(:testcase => @testcase)
      @original = Testsuite.find(@original.id)
      @copy = @original.create_version
    end
    
    it "should have the same attrbutes as the original" do
      puts "original: #{@original.attributes.inspect}"
      puts "copy: #{@copy.attributes.inspect}"
      @copy.attributes.each do |k,v|
        @original.attributes[k].should== v unless ['id', 'created_at', 'updated_at','version'].include?(k)
      end
    end
    
    it "should have a higher version" do
      @copy.version.should== @original.version + 1
    end

    it "should reference the same test cases" do
      #
      # i am still getting a weird mysql failure
      # if using @original.testcases and @copy.testcases
      #
      testcases = TestsuiteEntry.includes(:testcase).where(:testsuite_id => @copy.id).order('position').map(&:testcase)
      otestcases = TestsuiteEntry.includes(:testcase).where(:testsuite_id => @original.id).order('position').map(&:testcase)            
      testcases.each_with_index do |tc, idx|
        tc.id.should== otestcases[idx].id
      end
    end
  end
end
