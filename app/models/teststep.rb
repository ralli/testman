class Teststep < ActiveRecord::Base
  belongs_to :testcase
  acts_as_list :scope => :testcase

  validates_presence_of :step
  validates_presence_of :expected_result

  has_many :teststepruns, :dependent => :destroy
  attr_accessible :testcase, :position, :step, :expected_result

  def create_run(user, testcaserun)
    Teststeprun.create!(:created_by => user, :edited_by => user, :testcaserun => testcaserun, :teststep => self, :status => 'new', :result => 'unknown')
  end
end
