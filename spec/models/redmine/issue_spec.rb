require 'spec_helper'
require 'redmine/issue'

describe Redmine::Issue do
  let(:issue) { Redmine::Issue.new }
  let(:redmine_setting) { RedmineSetting.make }
  let(:bug_report) { BugReport.make }
  before do
    issue.stub(:save) { issue }
    Redmine::Issue.stub(:new) { issue }
  end

  it "should return an issue object" do
    Redmine::Issue.create(redmine_setting, bug_report)
  end
end