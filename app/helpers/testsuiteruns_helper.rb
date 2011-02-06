module TestsuiterunsHelper
  def nextcase(testrun)
    @nextcase = testrun.nextcase unless defined?(@nextcase)
    @nextcase
  end

  def nextstep(testcase)
    @nextstep = testcase.nextstep unless defined?(@nextstep)
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
end

