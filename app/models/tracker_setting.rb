class TrackerSetting < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :project
  validates_presence_of :site
  validates_presence_of :tracker_project_id
  validates_length_of :site, :maximum => 255
  validates_length_of :user, :maximum => 60
  validates_length_of :password, :maximum => 60
  validates_length_of :tracker_project_name, :maximum => 255
  validates_length_of :tracker_project_key, :maximum => 60
end
