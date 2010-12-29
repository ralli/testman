class Testcaserun < ActiveRecord::Base
  belongs_to :testsuiterun
  
  belongs_to :testcase
  validates_presence_of :testcase

  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']

  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']

  has_many :teststepruns, :dependent => :destroy, :order => 'position'
  
  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by
  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by
end
