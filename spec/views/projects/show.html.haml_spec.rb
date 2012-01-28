require 'spec_helper'

describe "projects/show.html.haml" do
  let(:user) { mock_model(User, :roles => [:admin]) }
  let(:tracker_setting) {mock_model(RedmineSetting, :site => 'http://localhost:3001', :user => 'testuser', :password => 'testpassword', :tracker_project_id => 1, :tracker_project_name => 'Redmineproject', :tracker_project_key => 'redmine')}

  before do
    view.controller.stub!(:current_user) {user}
  end

  it "should render settings creation links when no tracker settings exist" do
    project = mock_model(Project, :name => 'Some project', :tracker_setting => nil)
    assign(:project, project)
    render
    page = Capybara::Node::Simple.new(rendered)
    page.should have_content("Some project")
    rendered.should =~ Regexp.new(new_project_redmine_setting_path(project))
  end

  it "should not render settings creation links when tracker settings do exist" do
    project = mock_model(Project, :name => 'Some project', :tracker_setting => tracker_setting)
    assign(:project, project)
    render
    rendered.should_not =~ Regexp.new(new_project_redmine_setting_path(project))
    rendered.should =~ Regexp.new(tracker_setting.site)
    rendered.should =~ Regexp.new(tracker_setting.user)
    rendered.should =~ Regexp.new(tracker_setting.tracker_project_id.to_s)
    rendered.should =~ Regexp.new(tracker_setting.tracker_project_name)
    rendered.should =~ Regexp.new(tracker_setting.tracker_project_key)
  end
end