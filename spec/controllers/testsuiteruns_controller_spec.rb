require 'spec_helper'

describe TestsuiterunsController do
  let(:testsuiterun) { mock_model(Testsuiterun).as_null_object }
  let(:project) { mock_model(Project) }
  let(:user) { mock_model(User, :current_project => project, :locale => 'en', :roles => [:admin]) }

  before do
    session[:user_id] = user.to_param
    User.stub(:find).with(user.to_param) { user }
    Testsuiterun.stub(:find).with(testsuiterun.to_param) { testsuiterun }
  end

  context "PUT set_all_ok" do
    it "should set all teststeps to ok" do
      testsuiterun.should_receive(:set_all).with(user, 'ok')
      put :set_all_ok, :id => testsuiterun.to_param
    end

    it "should redirect to the testsuiteruns show page" do
      put :set_all_ok, :id => testsuiterun.to_param
      response.should redirect_to(testsuiterun)
    end
  end

  context "PUT set_all_failed" do
    it "should set all teststeps to failed" do
      testsuiterun.should_receive(:set_all).with(user, 'failed')
      put :set_all_failed, :id => testsuiterun.to_param
    end

    it "should redirect to the testsuiteruns show page" do
      put :set_all_failed, :id => testsuiterun.to_param
      response.should redirect_to(testsuiterun)
    end
  end

  describe "GET index" do
    context "with no current project" do
      let(:user) { mock_model(User, :current_project => nil, :locale => 'en', :roles => [:admin]) }

      before do
        session[:user_id] = 1
        User.stub(:find) { user }
      end

      it "should redirect to the root url" do
        get :index
        response.should redirect_to(root_url)
      end
    end
  end

end

