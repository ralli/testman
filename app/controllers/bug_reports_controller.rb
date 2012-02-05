require 'redmine/issue'

class BugReportsController < ApplicationController
  def new
    @testsuiterun = Testsuiterun.find(params[:testsuiterun_id])
    testsuite = @testsuiterun.testsuite
    title = I18n::t('controller.bug_reports.default_title', :testsuiteid => testsuite.id)
    url = url_for(@testsuiterun)
    message = I18n::t('controller.bug_reports.default_message', :testsuiteid => testsuite.id, :url => url)
    @bug_report = BugReport.new(:title => title, :message => message)
  end

  def create
    @testsuiterun = Testsuiterun.find(params[:testsuiterun_id])
    @bug_report = BugReport.new(params[:bug_report])
    @bug_report.testsuiterun = @testsuiterun
    BugReport.transaction do
      if @bug_report.valid?
        project = @testsuiterun.project
        redmine_setting = project.tracker_setting
        redmine_issue = Redmine::Issue.create(redmine_setting, @bug_report)
        @bug_report.bug_number= redmine_issue.to_param
        @bug_report.save!
        @testsuiterun.set_all(current_user, 'failed')
        redirect_to @testsuiterun, :notice => I18n::t('controller.bug_reports.successfully_created')
      else
        render 'new'
      end
    end
  end
end