class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  has_many :testcases, :dependent => :destroy
  has_many :testsuites, :dependent => :destroy
  has_many :current_users, :foreign_key => :current_project_id, :class_name => 'User', :dependent => :nullify

  has_many :testsuiteruns, :through => :testsuites
  has_many :testcaseruns, :through => :testcases
  has_many :teststeps, :through => :testcases

  has_one :tracker_setting, :dependent => :destroy

  def to_label
    name
  end

  def bug_url_for(bug_number)
    if self.tracker_setting.nil?
      nil
    else
      tracker_setting.bug_url_for(bug_number)
    end
  end
end
