require 'spec_helper'

describe Testsuite do

  describe "when validating" do
    def create_suite(attributes = {})
      project = Project.new
      project.stub(Project.make.attributes.merge({:id => 10}))

      user = User.new
      user.stub(User.make(:current_project => project).attributes.merge({:id => 10}))

      bla = {:project => project, :created_by => user, :edited_by => user}
      Testsuite.make(bla.merge(attributes))
    end

    it "should be valid" do
      testsuite = create_suite
      testsuite.should be_valid
    end

    it "should not be valid with no project" do
      testsuite = create_suite(:project => nil)
      testsuite.should_not be_valid
    end

    it "should not be valid with no user creating it" do
      testsuite = create_suite(:created_by => nil)
      testsuite.should_not be_valid
    end

    it "should not be valid with no user editing it" do
      testsuite = create_suite(:edited_by => nil)
      testsuite.should_not be_valid
    end
  end

  describe "when creating a new test run" do
    def make_full_suite
      project = Project.make!
      user = User.make!(:current_project => project)
      testcase = Testcase.make!(:project => project, :created_by => user, :edited_by => user)
      teststep = Teststep.make!(:testcase => testcase)
      testsuite = Testsuite.make!(:project => project, :created_by => user, :edited_by => user)
      testsuite.testsuite_entries.create(:testcase => testcase)
      Testsuite.find(testsuite.id)
    end

    it "should create a valid test run" do
      suite = make_full_suite
      suite.create_run(suite.created_by)
    end
  end

  describe "when searching" do
    it "should find matches within the name" do
      project = Project.make!
      user = User.make!
      testsuite = Testsuite.make!(:project => project, :created_by => user, :edited_by => user, :name => 'My Bingo Bongo')
      testsuites = Testsuite.search('bingo')
      testsuites.size.should== 1
      testsuites.first.name.should== 'My Bingo Bongo'
    end

    it "should find matches within the description" do
      project = Project.make!
      user = User.make!
      testsuite = Testsuite.make!(:project => project, :created_by => user, :edited_by => user, :description => 'My Bingo Bongo')
      testsuites = Testsuite.search('bingo')
      testsuites.size.should== 1
      testsuites.first.description.should== 'My Bingo Bongo'      
    end
  end

  describe "when creating a new version" do
    before :all do
      @project = Project.make!
      @user = User.make!(:current_project => @project)
      @testcase = Testcase.make!(:project => @project, :created_by => @user, :edited_by => @user)
      @teststep = @testcase.teststeps.make!
      @original = Testsuite.make!(:project => @project, :created_by => @user, :edited_by => @user)
      @original.testsuite_entries.create(:testcase => @testcase)
      @original = Testsuite.find(@original.id)
      @copy = @original.create_version(@user)
    end
    
    it "should have the same attrbutes as the original" do
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
