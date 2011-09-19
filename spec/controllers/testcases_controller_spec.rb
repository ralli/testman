require 'spec_helper'

describe TestcasesController do
  let(:tag_count) { mock_model(ActsAsTaggableOn::Tag) }
  let(:testcase) { mock_model(Testcase).as_null_object }
  let(:user) { mock_model(User, :role_symbols => [:admin], :locale => 'en') }
  let(:project) { mock_model(Project) }

  before(:each) do
    Testcase.stub(:tag_counts) { [tag_count] }
    session[:user_id] = user.to_param
    User.stub(:find).with(user.to_param) { user }
    user.stub(:current_project) { project }
  end

  describe "GET index" do
    context "without a current project" do
      before do
        user.stub(:current_project) { nil }
      end

      it "should redirect to the root url" do
        get 'index'
        response.should redirect_to(root_url)
      end

      it "should show an alert message" do
        get 'index'
        flash[:alert].should_not be_nil
      end
    end
  end

  describe "GET search" do
    it "should render the index template" do
      project.stub_chain(:testcases, :order, :paginate) { [testcase] }
      get :search, :search => ''
      response.should render_template('index')
    end

    it "should should assign tag_counts" do
      project.stub_chain(:testcases, :order, :paginate) { [testcase] }
      get :search, :search => ''
      assigns(:tag_counts).should include(tag_count)
    end

    context "when no search term given" do
      it "should return all testcases of the current project" do
        project.stub_chain(:testcases, :order, :paginate) { [testcase] }
        get :search, :search => ''
        assigns(:testcases).should include(testcase)
      end
    end

    context "with a search term given" do
      it "should return all matching testcases of the current project" do
        Testcase.stub_chain(:search, :where, :paginate) { [testcase] }
        get :search, :search => 'xxx'
        assigns(:testcases).should include(testcase)
      end
    end
  end

  describe "POST create" do
    before do
       Testcase.stub(:new) { testcase }
    end

    context "with validation errors" do
      before do
        testcase.stub(:save) { false }
      end

      it "should assign the testcase" do
        post :create, :testcase => {}
        assigns(:testcase).should == testcase
      end

      it "should render the 'new' template" do
        post :create, :testcase => {}
        response.should render_template('new')
      end
    end
  end

  describe "GET edit" do
    before do
      Testcase.stub(:find).with(testcase.to_param) { testcase }
    end

    it "should assign the testcases" do
      get :edit, :id => testcase.to_param
      assigns(:testcase).should == testcase
    end

    it "should render the edit template" do
      get :edit, :id => testcase.to_param
      response.should render_template('edit')
    end
  end

  describe "PUT update" do
    before do
      Testcase.stub(:find).with(testcase.to_param) { testcase }
    end

    it "should update the edited_by attribute with the current user" do
      testcase.should_receive(:'edited_by=').with(user)
      testcase.stub(:update_attributes) { false }
      put :update, :id => testcase.to_param, :testcase => {}
    end

    context "with validation errors" do
      before do
        testcase.stub(:update_attributes) { false }
      end

      it "should assign the testcase" do
        put :update, :id => testcase.to_param, :testcase => {}
        assigns(:testcase).should == testcase
      end

      it "should render the 'edit' template" do
        put :update, :id => testcase.to_param, :testcase => {}
        response.should render_template('edit')
      end
    end

    context "without validation errors" do
      before do
        testcase.stub(:update_attributes) { true }
      end

      it "should redirect to the testcases page" do
        put :update, :id => testcase.to_param, :testcase => {}
        response.should redirect_to(@testcase)
      end

      it "should show a success message" do
        put :update, :id => testcase.to_param, :testcase => {}
        flash[:notice].should_not be_nil
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Testcase.stub(:find).with(testcase.to_param) { testcase }
    end

    it "should destroy the testcase" do
      testcase.should_receive(:destroy)
      delete 'destroy', :id => testcase.to_param
    end

    it "should redirect to the list of testcases" do
      delete 'destroy', :id => testcase.to_param
      response.should redirect_to(testcases_url)
    end

    it "should show a notification message" do
      delete 'destroy', :id => testcase.to_param
      flash[:notice].should_not be_nil
    end
  end

  describe "XHR POST sort_teststeps" do
    before do
      Testcase.stub(:find).with(testcase.to_param) { testcase }
      Teststep.stub(:update_all)
    end

    it "should update all teststeps ignoring the first teststep parameter" do
      Teststep.should_receive(:update_all).with(["position=?", 1], ['id=?', 3])
      Teststep.should_receive(:update_all).with(["position=?", 2], ['id=?', 2])
      xhr :post, 'sort_teststeps', :id => testcase.to_param, :teststeps => ['0', '3', '2']
    end

    it "should not render anything" do
      xhr :post, 'sort_teststeps', :id => testcase.to_param, :teststeps => []
      response.body.should be_blank
    end
  end

  describe "XHR POST sort_attachments" do
    before do
      Testcase.stub(:find).with(testcase.to_param) { testcase }
      Teststep.stub(:update_all)
    end

    it "should update all attachments ignoring the first teststep parameter" do
      TestcaseAttachment.should_receive(:update_all).with(["position=?", 1], ['id=?', 3])
      TestcaseAttachment.should_receive(:update_all).with(["position=?", 2], ['id=?', 2])
      xhr :post, 'sort_attachments', :id => testcase.to_param, :attachment => ['3', '2']
    end

    it "should not render anything" do
      xhr :post, 'sort_attachments', :id => testcase.to_param, :attachment => []
      response.body.should be_blank
    end
  end
end

