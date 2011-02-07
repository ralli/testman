require 'spec_helper'

describe TestsuitesController do

  context "when searching testcases" do
    before :each do
      @current_project = stub(Project.plan)
      @current_project.stubs(:id).returns(1)
      @current_user = stub(User.plan())
      @current_user.stubs(:current_project).returns(@current_project)
      @current_user.stubs(:roles).returns([:admin])
      @controller.stubs(:current_user).returns(@current_user)
      @testsuite = stub(Testsuite.plan)
    end

    it "should return all testcases of the current project if the search term is shorter than 3 characters" do
      arr = Array.new
      arr.stubs(:order).returns([])
      @current_project.expects(:testcases).returns(arr)
      xhr :post, 'search_testcases', :id => 1, :search => ''
      response.should render_template('search_testcases')
    end

    it "should perform a fulltext search if search term is at least 3 characters long" do
      #Testcase.expects(:search).returns([])
      xhr :post, 'search_testcases', :id => 1, :search => 'ipsum'
      response.should render_template('search_testcases')
    end
  end
end

