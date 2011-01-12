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
    s = "Testcase ##{testcaserun.position}"
    if testcaserun.testsuiterun then
      s << " of #{testcaserun.testcasecount}"
    end
    s
  end

  def label_for_teststep(teststeprun)
    "Teststep ##{teststeprun.teststep.position} of #{teststeprun.teststepcount}"
  end

  def completed_percentage
    if @teststep_count == 0
      100
    else
      (@completed_teststep_count.to_f / @teststep_count.to_f) * 100
    end
  end
end
