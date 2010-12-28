class Testsuiterun < ActiveRecord::Base
  belongs_to :testsuite
  validates_presence_of :testsuite
  
  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'skipped', 'ended']
  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'passed', 'failed']

  has_many :testcaseruns, :dependent => :destroy
  belongs_to :current_testcaserun
  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by
  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by
end
