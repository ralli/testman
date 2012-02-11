module TestsuiterunsHelper
  def nextcase(testrun)
    @nextcase = testrun.nextcase unless defined?(@nextcase)
    @nextcase
  end

  def nextstep(testcase)
    return nil if testcase.nil?
    @nextstep ||= testcase.nextstep
    @nextstep
  end

  def show_steplink?(testrun)
    testrun.status != 'ended'
  end

  def label_for_testcase(testcaserun)
    t('helpers.testsuiteruns.label_for_testcase', :position => testcaserun.position, :count => testcaserun.testcasecount)
  end

  def label_for_teststep(teststeprun)
    t('helpers.testsuiteruns.label_for_teststep', :position => teststeprun.teststep.position, :count => teststeprun.teststepcount)
  end

  def completed_percentage
    if @teststep_count == 0
      100
    else
      (@completed_teststep_count.to_f / @teststep_count.to_f) * 100
    end
  end

  def options_for_status
    [[I18n.t('helpers.status.all'), ''], [I18n.t('helpers.status.new'), 'new'], [I18n.t('helpers.status.ended'), 'ended']]
  end

  def options_for_result
    [[I18n.t('helpers.result.all'), ''],
     [I18n.t('helpers.result.ok'), 'ok'],
     [I18n.t('helpers.result.failed'), 'failed'],
     [I18n.t('helpers.result.unknown'), 'unknown']]
  end

  def bug_report_link(testsuiterun, report)
    if report.bug_number.nil?
      content_tag(:a, "#{report.to_param} - #{report.title}", :href => url_for([testsuiterun, report]))
    else
      content_tag(:a, "#{report.bug_number} - #{report.title}", :href => testsuiterun.bug_url_for(report.bug_number), :target => '_blank')
    end
  end
end

