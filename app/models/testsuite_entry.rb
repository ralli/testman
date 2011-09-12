class TestsuiteEntry < ActiveRecord::Base
  belongs_to :testsuite
  belongs_to :testcase
  acts_as_list :scope => :testsuite

  validates_presence_of :testsuite
  validates_presence_of :testcase
end

