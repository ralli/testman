require 'spec_helper'

describe UsersController do
  let(:user) { mock_model(User, :role_symbols => [:admin], :locale => 'en') }
  before do
    session[:user_id] = user.to_param
    User.stub(:find).with(user.to_param) { user }
  end

  describe "POST create" do
    context "with validation errors" do
      before do
        User.stub(:new) { user }
      end

      it "should assign a user variable" do
        user.stub(:save) { false }
        post :create, :user => { }
        assigns(:user).should_not be_nil
      end

      it "should render the 'new' template" do
        user.stub(:save) { false }
        post :create, :user => { }
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    context "with validation errors" do
      before do
        user.stub(:update_attributes) { false }
      end

      it "should have the user assigned" do
        put :update, :id => user.to_param, :user => {}
        assigns(:user).should == user
      end

      it "should render the edit template" do
        put :update, :id => user.to_param, :user => {}
        response.should render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    let(:user_to_destroy) { mock_model(User, :role_symbols => [:manager, :tester], :locale => 'en' ) }

    before do
      User.stub(:find).with(user_to_destroy.to_param) { user_to_destroy }
    end

    context "when trying to delete the current user" do
      it "should show a notice stating the current user cannot be deleted" do
        delete :destroy, :id => user.to_param
        flash[:alert].should_not be_nil
      end

      it "should redirect to the users list if the current user has administration rights" do
        delete :destroy, :id => user.to_param
        response.should redirect_to(users_url)
      end

      it "should redirect to the root url if current user has no administration rights" do
        session[:user_id] = user_to_destroy.to_param
        delete :destroy, :id => user_to_destroy.to_param
        response.should redirect_to(root_url)
      end
    end

    context "when trying to delete another user" do
      it "should show a success message" do
        delete :destroy, :id => user_to_destroy.to_param
        flash[:notice].should_not be_nil
      end

      it "should redirect to the users list" do
        delete :destroy, :id => user_to_destroy.to_param
        response.should redirect_to(users_url)
      end
    end
  end
end

