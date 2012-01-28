require 'spec_helper'

describe RedmineSettingsController do
  let(:user) { mock_model(User, :roles => [:admin])}
  let(:project) { mock_model(Project) }
  let(:redmine_setting) { mock_model(RedmineSetting).as_null_object }
  let(:redmine_project) { mock_model(Redmine::Project, :name => 'Redmine project', :identifier => 'redmine_project') }

  before do
    controller.stub(:current_user) { user }
    Project.stub(:find).with(project.to_param) { project }
    Redmine::Project.stub(:find_by_id) { redmine_project }
    redmine_setting.stub(:all_redmine_projects) {[redmine_project]}
  end

  describe "GET new" do
    before do
      RedmineSetting.stub(:new) { redmine_setting }
    end

    it "should assign the project" do
      get 'new', :project_id => project.to_param
      assigns(:project).should == project
      assigns(:redmine_setting).should == redmine_setting
    end
    it "should render the new page" do
      get 'new', :project_id => project.to_param
      response.should render_template('new')
    end
  end

  describe "POST create" do
    before do
      RedmineSetting.stub(:new) { redmine_setting }
    end
    context "when update_trigger given" do
      context "with validation errors" do
        before do
          redmine_setting.stub(:save) { false }
        end
        it "should show the choose project page" do
          post :create, :project_id => project.to_param, :redmine_setting => {:tracker_project_id => 1}, :update_trigger => true
          response.should render_template('choose_project')
        end
      end
      context "without validation errors" do
        before do
          redmine_setting.stub(:save) { true }
        end

        it "should redirect to the project page" do
          post :create, :project_id => project.to_param, :redmine_setting => {:tracker_project_id => 1}, :update_trigger => true
          response.should redirect_to(project)
        end

        it "should show a success message" do
          post :create, :project_id => project.to_param, :redmine_setting => {:tracker_project_id => 1}, :update_trigger => true
          flash[:notice].should_not be_nil
        end
      end
    end
    context "when update trigger is not given" do
      it "should have the list of redmine_settings assigned" do
        post :create, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }
        assigns(:redmine_projects).should_not be_nil
      end
      it "should show the choose project page" do
        post :create, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }
        response.should render_template('choose_project')
      end
    end
  end

  describe "PUT update" do
    before do
      project.stub(:tracker_setting) { redmine_setting }
    end

    context "when update trigger given" do
      context "with validation errors" do
        before do
          redmine_setting.stub(:update_attributes) { false }
        end

        it "should render the choose project page" do
          put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }, :update_trigger => 'true'
          response.should render_template('choose_project')
        end
        it "should have the list of redmine projects assigned" do
          put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }, :update_trigger => 'true'
          assigns(:redmine_projects).should_not be_nil
        end
      end

      context "without validation errors" do
        before do
          redmine_setting.stub(:update_attributes) { true }
        end
        it "should redirect to the project page" do
          put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }, :update_trigger => 'true'
          response.should redirect_to(project)
        end
        it "should show a success message" do
          put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }, :update_trigger => 'true'
          flash[:notice].should_not be_nil
        end
      end
    end

    context "when update trigger is not given" do
      it "should render the choose project page" do
        put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }
        response.should render_template('choose_project')
      end

      it "should have the list of redmine projects assigned" do
        put :update, :project_id => project.to_param, :redmine_setting => {:user => 'user', :password => 'password' }
        assigns(:redmine_projects).should_not be_nil
      end
    end
  end
end
