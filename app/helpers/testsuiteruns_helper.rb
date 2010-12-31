module TestsuiterunsHelper
  def nextcase(testrun)
    @nextcase = testrun.nextcase unless defined?(@nextcase)    
    @nextcase
  end

  def nextstep(testcase)
    @nextstep = testcase.nextstep unless defined?(@nextstep)
    puts "#{@nextstep.inspect}"
    @nextstep
  end
end
