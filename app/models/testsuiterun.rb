class Testsuiterun < ActiveRecord::Base
  belongs_to :testsuite
  validates_presence_of :testsuite
  
  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']
  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']

  has_many :testcaseruns, :dependent => :destroy, :order => 'position'
  has_many :teststepruns, :through => :testcaseruns
  
  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by
  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by

  def nextcase
    return nil unless step?
    testcaseruns.where(['status <> ?', 'ended']).includes(:testcase).first
  end

  def next?
    not nextcase.nil?
  end

  def step?
    status != 'ended'
  end

  def teststep_count
    teststepruns.count
  end
  
  def completed_teststep_count
    teststepruns.where('teststepruns.status=?', 'ended').count
  end

  def step(user, result)
    c = nextcase
    return nil if c.nil?
    c.step(user, result)
    update_attributes!(:edited_by => user, :status => 'ended', :result => result) if nextcase.nil?
  end
end
