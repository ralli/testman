require 'spec_helper'

describe TestsuitesController do
  let(:current_project) { mock_model(Project) }
  let(:testcase) { mock_model(Testcase) }
  let(:user) { mock_model(User, :current_project => current_project, :locale => 'en', :roles => [:admin]) }
  let(:testsuite) { mock_model(Testsuite).as_null_object }
  let(:testsuiteentry) { mock_model(TestsuiteEntry) }

  before do
    session[:user_id] = user.to_param
    User.stub(:find).with(user.to_param) { user }
    Testsuite.stub(:find).with(testsuite.to_param) { testsuite }
  end

  describe "GET search_testcases" do
    it "should return all testcases of the current project if the search term is too short" do
      current_project.stub_chain(:testcases, :order) { [testcase] }
      xhr :post, "search_testcases", :id => current_project.id, :search => 'x'
      assigns(:testcases).should include(testcase)
    end

    it "should return all testcases of the current project if the search term is long enough" do
      testcases = Array.new
      testcases.stub(:where).and_return([testcase])
      Testcase.should_receive(:search).with('xxxx').and_return(testcases)
      xhr :post, "search_testcases", :id => current_project.id, :search => 'xxxx'
      assigns(:testcases).should include(testcase)
    end
  end

  describe "POST create" do
    context "with validation errors" do
      before do
        Testsuite.stub(:new_with_defaults) { testsuite }
        testsuite.stub(:save) { false }
      end

      it "should have assigned a testsuite" do
        post :create, :testsuite => {}
        assigns(:testsuite).should == testsuite
      end

      it "should render the 'new' template" do
        post :create, :testsuite => {}
        response.should render_template('new')
      end
    end
  end

  describe "GET show_add" do
    context "when there are no testcases assigned to the testsuite" do
      before do
        testsuite.stub_chain(:testsuite_entries, :includes) { [] }
      end

      it "should search the testcases of the current project" do
         testcases = Array.new
         current_project.should_receive(:testcases) { testcases }
         testcases.stub(:order) { testcases }
         get :show_add, :id => testsuite.to_param
      end

      it "should assign testcases" do
         testcases = Array.new
         current_project.stub_chain(:testcases, :order) { testcases }
         get :show_add, :id => testsuite.to_param
         assigns(:testcases).should == testcases
      end
    end

    context "when there are already testcases assigned to the testsuite" do
      before do
        testsuite.stub_chain(:testsuite_entries, :includes) { [testsuiteentry] }
      end

      it "should exclude the testcases already assigned to the testsuite" do
        testcases = [testcase]
        testsuite.stub(:testcases) { testcases }
        a = []
        current_project.stub_chain(:testcases, :order) { a }
        a.should_receive(:where).with('testcases.id not in (?)', testcases)
        get :show_add, :id => testsuite.to_param
      end

      it "should assign testcases" do
         testcases = Array.new
         current_project.stub_chain(:testcases, :order, :where) { testcases }
         get :show_add, :id => testsuite.to_param
         assigns(:testcases).should == testcases
      end
    end
  end

  describe "PUT update" do
    context "with validation errors" do
      before do
        testsuite.stub(:update_attributes) { false }
      end

      it "should assign the testsuite" do
        put :update, :id => testsuite.to_param, :testsuite => {}
        assigns(:testsuite).should == testsuite
      end

      it "should render the 'edit' template" do
        put :update, :id => testsuite.to_param, :testsuite => {}
        response.should render_template('edit')
      end
    end
  end

  describe "XHR POST sort_testcases" do
    it "should update the testcases positions" do
      TestsuiteEntry.should_receive(:update_all).with(['position=?', 1], ['id=?', 2])
      TestsuiteEntry.should_receive(:update_all).with(['position=?', 2], ['id=?', 1])
      xhr :post, 'sort_testcases', :id => testsuite.to_param, :tctable => ['0', '2', '1']
    end

    it "should render nothing" do
      xhr :post, 'sort_testcases', :id => testsuite.to_param, :tctable => []
      response.body.should be_blank
    end
  end

  describe "XHR POST assign_testcase" do
    before do
      testsuite.stub_chain(:testsuite_entries, :includes) { [testsuiteentry] }
      TestsuiteEntry.stub(:update_all)
    end

    context "with no entry ids given" do
      it "should assign the testsuite_entries" do
        xhr :post, 'assign_testcase', :id => testsuite.to_param, :entryid => []
        assigns(:testsuite_entries).should == [testsuiteentry]
      end
    end

    context "with no entry ids but no testcase id given" do
      it "should assign the testsuite_entries" do
        xhr :post, 'assign_testcase', :id => testsuite.to_param, :entryid => ['e1', 'e2', 'e3']
        assigns(:testsuite_entries).should == [testsuiteentry]
      end
      it "should update the testsuite_entries positions" do
        TestsuiteEntry.should_receive(:update_all).with(['position=?', 1], ['id=?', 2])
        TestsuiteEntry.should_receive(:update_all).with(['position=?', 2], ['id=?', 1])
        xhr :post, 'assign_testcase', :id => testsuite.to_param, :entryid => ['e2', 'e1']
      end
    end

    context "with  entry ids and a testcase id given" do
      before do
        Testcase.should_receive(:find) { testcase }
        testsuite.stub(:add_testcase) { testsuiteentry }
      end

      it "should assign the testsuite_entries" do
        xhr :post, 'assign_testcase', :id => testsuite.to_param, :entryid => ['e1', 'e2', 't3']
        assigns(:testsuite_entries).should == [testsuiteentry]
      end

      it "should update the testsuite_entries positions" do
        TestsuiteEntry.should_receive(:update_all).with(['position=?', 1], ['id=?', 2])
        TestsuiteEntry.should_receive(:update_all).with(['position=?', 2], ['id=?', testsuiteentry.id])
        TestsuiteEntry.should_receive(:update_all).with(['position=?', 3], ['id=?', 1])
        xhr :post, 'assign_testcase', :id => testsuite.to_param, :entryid => ['e2', 't3', 'e1']
      end
    end
  end

  describe "XHR POST remove_testcase" do
    before do
      TestsuiteEntry.stub(:find).with(testsuiteentry.to_param.to_i) { testsuiteentry }
    end

    it "should destroy the testsuiteentry" do
      testsuiteentry.should_receive(:destroy)
      xhr :post, 'remove_testcase', :id => testsuite.to_param, :entryid => testsuiteentry.to_param
    end

    it "should assign a notice to indicate success" do
      xhr :post, 'remove_testcase', :id => testsuite.to_param, :entryid => testsuiteentry.to_param
      assigns(:notice).should_not be_nil
    end
  end

  describe "GET search" do
    context "when no search parameter given" do
      before do
        Testsuite.stub_chain(:order, :paginate) { [testsuite] }
      end

      it "should assign the tesuites" do
        get 'search', :q => ''
        assigns(:testsuites).should == [testsuite]
      end

      it "should render the 'index' page" do
        get 'search', :q => ''
        response.should render_template('index')
      end
    end
  end
end

