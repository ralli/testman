class Teststeprun < ActiveRecord::Base
  belongs_to :testcaserun
  validates_presence_of :testcaserun
  belongs_to :teststep
  validates_presence_of :teststep
  
  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']

  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']

  belongs_to :created_by, :class_name => "User"
  belongs_to :edited_by, :class_name => "User"

  validates_presence_of :created_by
  validates_presence_of :edited_by
  
  def step(user, result)
    update_attributes!(:edited_by => user, :status => 'ended', :result => result)
  end

  def step?
    status != 'ended'
  end

  def next?
    false
  end

  def teststepcount
    testcaserun.try(:teststepruns).try(:count) || 0
  end
end