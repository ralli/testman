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
end
