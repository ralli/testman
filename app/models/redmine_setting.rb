require 'redmine/project'

class RedmineSetting < TrackerSetting
  def all_redmine_projects
    Redmine::Project.find_all(self.site, self.user, self.password)
  end

  def bug_url_for(bug_number)
    URI.join(self.site, "issues/#{bug_number}")
  end
end