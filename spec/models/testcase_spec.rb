require File.dirname(__FILE__) + '/../spec_helper'

describe Testcase do
  def make_unsaved_testcase(attributes = {})
    project = Project.make
    user = User.make
    Testcase.make_unsaved(attributes.merge({:key => 'NEW', :project => project, :created_by => user, :edited_by => user }))
  end

  it "should be valid" do
    testcase = make_unsaved_testcase
    puts testcase.errors.inspect unless testcase.valid?
    testcase.should be_valid
  end

  def self.check_invalid_value(attribute)
    it "should not be valid if an invalid #{attribute.to_s} given" do
      make_unsaved_testcase(attribute => 'invalid').should_not be_valid
    end
  end

  check_invalid_value(:test_area)
  check_invalid_value(:test_variety)
  check_invalid_value(:test_level)
  check_invalid_value(:execution_type)
  check_invalid_value(:test_status)
  check_invalid_value(:test_priority)
  check_invalid_value(:test_method)

end
