class RedmineSetting < TrackerSetting
  validates_presence_of :site
  validates_length_of :site, :maximum => 255
  validates_length_of :user, :maximum => 60
  validates_length_of :password, :maximum => 60
end