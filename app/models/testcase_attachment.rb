class TestcaseAttachment < ActiveRecord::Base
  belongs_to :testcase
  acts_as_list :scope => :testcase
  has_attached_file :attachment
end
