require 'spec_helper'

describe UserSessionsController do
  describe "POST create" do
    let(:user_session) { mock_model(UserSession, :login => 'login', :password => 'password').as_null_object }
    let(:user) { mock_model(User) }

    before do
      UserSession.stub(:new) { user_session }
    end

    context "with missing user name or password" do
      before do
        user_session.stub(:valid?) { false }
      end

      it "should render the 'new' template" do
        post :create, :user_session => {}
        response.should render_template('new')
      end
    end

    context "with invalid username" do
      before do
        user_session.stub(:valid?) { true }
        User.stub(:find_by_login).with('login') { nil }
      end

      it "should have a user session with no password assigned" do
        user_session.should_receive(:'password=').with(nil)
        post :create, :user_session => { :login => 'login', :password => 'password' }
      end

      it "should show an alert message" do
        post :create, :user_session => { :login => 'login', :password => 'password' }
        flash[:alert].should_not be_nil
      end

      it "should render the 'new' template" do
        post :create, :user_session => { :login => 'login', :password => 'password' }
        response.should render_template('new')
      end
    end
  end

  describe "DELETE destroy" do
    it "should clear the current user id" do
      delete :destroy
      session[:user_id].should be_nil
    end

    it "should should show a notification message" do
      delete :destroy
      flash[:notice].should_not be_nil
    end

    it "should redirect to the root url" do
      delete :destroy
      response.should redirect_to(root_url)
    end
  end
end

