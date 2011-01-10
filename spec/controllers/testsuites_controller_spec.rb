require 'spec_helper'

describe TestsuitesController do
  before :each  do
    @current_project = Project.stubs(Project.plan)
    @current_project.stubs(:id).returns(1)
    @current_user = User.stubs(User.plan())
    @current_user.stub(:current_project).and_return(@current_project)
    @current_user.stub(:roles).and_return([:admin])
    @controller.stub(:current_user).and_return(@current_user)
  end

  context "when searching testcases" do
    before :each do
      @testsuite = Testsuite.stubs(Testsuite.plan)
    end
    
    it "should return all testcases of the current project if the search term is shorter than 3 characters" do
      arr = Array.new
      arr.stubs(:order).returns([])
      @current_project.expects(:testcases).returns(arr)
      xhr :post, 'search_testcases', :id => @testsuite.to_param, :search => ''
      response.should render_template('search_testcases')
    end
  
    it "should perform a fulltext search if search term is at least 3 characters long" do
      Testcase.expects(:search).returns([])
      xhr :post, 'search_testcases', :id => @testsuite.to_param, :search => 'ipsum'
      response.should render_template('search_testcases')
    end
  end
end
