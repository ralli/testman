module Redmine
  class Issue < ActiveResource::Base
    def self.create(redmine_settings, bug_report)
      ActiveResource::Base.site = redmine_settings.site
      ActiveResource::Base.user = redmine_settings.user
      ActiveResource::Base.password = redmine_settings.password
      ActiveResource::Base.format = :json
      issue = Redmine::Issue.new
      issue.project_id = redmine_settings.tracker_project_id
      issue.tracker_id = 1
      issue.status_id = 1
      issue.priority_id = 4
      issue.subject = bug_report.title
      issue.description = bug_report.message
      issue.save
      issue
    end
  end
end