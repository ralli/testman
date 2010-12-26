class Teststep < ActiveRecord::Base
  belongs_to :testcase
  acts_as_list :scope => :testcase

  validates_presence_of :step
  validates_presence_of :expected_result

  attr_accessible :testcase, :position, :step, :expected_result
end
