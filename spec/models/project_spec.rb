require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid" do
    Project.make_unsaved.should be_valid
  end

  check_length Project, :name, 80
  check_required Project, :name
end
