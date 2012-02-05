class BugReport < ActiveRecord::Base
  validates_length_of :title, :maximum => 100
  validates_presence_of :title
  validates_presence_of :message
  validates_presence_of :testsuiterun

  belongs_to :testsuiterun
  has_one :testsuite, :through => :testsuiterun

  belongs_to :testcaserun
  belongs_to :testsuiterun
end