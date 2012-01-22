require 'spec_helper'

describe ProjectsController do
  let(:project) { mock_model(Project).as_null_object }
  let(:user) { mock_model(User, :current_project => project, :locale => 'en', :roles => [:admin]) }

  before do
    session[:user_id] = 1
    User.stub(:find) { user }
    user.stub(:reload) { user }
  end

  describe "GET new" do
    before do
      Project.stub(:new) { project }
    end

    it "should assign a project" do
        get :new
        assigns(:project).should == project
    end
  end

  describe "GET activatable_projects" do
    before do
      Project.stub(:all).and_return([project])
    end

    it "should assign all projects" do
      get 'activatable_projects'
      assigns(:projects).should include(project)
    end

    it "should render its view" do
      get :activatable_projects
      response.should render_template('activatable_projects')
    end
  end

  describe "GET activate_project" do
    before do
      Project.stub(:find).with(project.to_param) { project }
    end

    it "should assign the project to the current user" do
      user.stub_chain(:reload, :update_attribute)
      get 'activate', :id => project.to_param
    end

    it "should redirect to the root url" do
      user.stub_chain(:reload, :update_attribute)
      get 'activate', :id => project.to_param
      response.should redirect_to(root_url)
    end

    it "should assign a success message" do
      user.stub_chain(:reload, :update_attribute)
      get 'activate', :id => project.to_param
      flash[:notice].should_not be_nil
    end
  end

  describe "PUT update" do
    before do
      Project.stub(:find).with(project.to_param) { project }
    end

    context "with failing validation" do
      it "should render the edit template" do
        project.stub(:update_attributes) { false }
        put :update, :id => project.to_param, :project => { :name => 'whatever' }
        response.should render_template('edit')
      end
    end
  end
end

