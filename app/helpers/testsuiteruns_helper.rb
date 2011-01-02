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
      s << " of #{testcaserun.testsuiterun.testcaseruns.count}"
    end
    s
  end

  def label_for_teststep(teststeprun)
    "Teststep ##{teststeprun.teststep.position} of #{teststeprun.testcaserun.teststepruns.count}"
  end
end
