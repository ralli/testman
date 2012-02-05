class BugReport < ActiveRecord::Base
  validates_length_of :title, :maximum => 100
  validates_presence_of :title
  validates_presence_of :message
  belongs_to :testsuiterun
  has_one :testsuite, :through => :testsuiterun
end