require 'redmine/issue'

class BugReportsController < ApplicationController
  def new
    @testsuiterun = Testsuiterun.find(params[:testsuiterun_id])
    testsuite = @testsuiterun.testsuite
    url = url_for(@testsuiterun)
    if params[:teststeprun_id].blank?
      title = I18n::t('controller.bug_reports.default_title', :testsuiteid => testsuite.id)
      message = I18n::t('controller.bug_reports.default_message', :testsuiteid => testsuite.id, :url => url)
    else
      teststeprun = Teststeprun.find(params[:teststeprun_id])
      testcaserun = Testcaserun.find(params[:testcaserun_id])
      title = I18n::t('controller.bug_reports.default_title_with_details', :testsuiteid => testsuite.id, :teststep_no => teststeprun.position, :testcase_no => testcaserun.position)
      testcase_url = url_for(testcaserun.testcase)
      message = I18n::t('controller.bug_reports.default_message_with_details', :testsuiteid => testsuite.id, :url => url, :testcase_url => testcase_url, :teststep_no => teststeprun.position, :testcase_no => testcaserun.position)
    end
    @bug_report = BugReport.new(:title => title, :message => message)
    @bug_report.testcaserun_id = params[:testcaserun_id]
    @bug_report.teststeprun_id = params[:teststeprun_id]
  end

  def create
    @testsuiterun = Testsuiterun.find(params[:testsuiterun_id])
    @bug_report = BugReport.new(params[:bug_report])
    @bug_report.testsuiterun = @testsuiterun
    BugReport.transaction do
      if @bug_report.valid?
        project = @testsuiterun.project
        redmine_setting = project.tracker_setting
        unless redmine_setting.nil?
          redmine_issue = Redmine::Issue.create(redmine_setting, @bug_report)
          @bug_report.bug_number= redmine_issue.to_param
        end
        @bug_report.save!
        if @bug_report.teststeprun_id.nil?
          @testsuiterun.set_all(current_user, 'failed')
        else
          @testsuiterun.step(current_user, "failed")
        end
        redirect_to @testsuiterun, :notice => I18n::t('controller.bug_reports.successfully_created')
      else
        render 'new'
      end
    end
  end

  def show
    @testsuiterun = Testsuiterun.find(params[:testsuiterun_id])
    @bug_report = BugReport.find(params[:id])
  end
end