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
    if @bug_report.valid?
      project = @testsuiterun.project
      redmine_setting = project.tracker_setting
      Redmine::Issue.create(redmine_setting, @bug_report)
      Testsuiterun.transaction do
        @testsuiterun.set_all(current_user, 'failed')
      end
      redirect_to @testsuiterun, :notice => 'Successfully created issue'
    else
      render 'new'
    end
  end
end