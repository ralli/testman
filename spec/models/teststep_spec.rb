require 'spec_helper'

describe Teststep do
  def create_teststep(attributes = {})
    project = Project.new
    project.stubs(Project.plan.merge({:id => 10}))
    
    user = User.new
    user.stubs(User.plan(:current_project => project).merge({:id => 10}))

    testcase = Testcase.new
    testcase.stubs(Testcase.plan(:project => project, :created_by => user, :edited_by => user).merge({:id => 10}))

    Teststep.make_unsaved(attributes)
  end

  it "should be valid" do
    teststep = create_teststep
    teststep.should be_valid
  end

  it "should require a step definition" do
    teststep = create_teststep(:step => nil)
    teststep.should_not be_valid
  end

  it "should require a expected result" do
    teststep = create_teststep(:expected_result => nil)
    teststep.should_not be_valid
  end
end
