require 'redmine/project'

class RedmineSetting < TrackerSetting
  def all_redmine_projects
    Redmine::Project.find_all(self.site, self.user, self.password)
  end
end