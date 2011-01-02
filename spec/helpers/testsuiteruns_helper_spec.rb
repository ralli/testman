require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the TestsuiterunsHelper. For example:
#
# describe TestsuiterunsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe TestsuiterunsHelper do
  it "should respond to nextcase" do
    testcase = Testcaserun.new
    testsuite = Testsuiterun.make_unsaved
    testsuite.stubs(:nextcase).returns(testcase)
    nextcase(testsuite).should== testcase
  end

  it "should respond to nextstep" do
    teststep = Teststeprun.new
    testcase = Testcaserun.new
    testcase.stubs(:nextstep).returns(teststep)
    nextstep(testcase).should== teststep
  end

  it "should not show a step link if status is ended" do
    testsuiterun = Testsuiterun.new
    testsuiterun.stubs(:status => 'ended')
    show_steplink?(testsuiterun).should be_false
  end

  it "should show a step link if status is not ended" do
    testsuiterun = Testsuiterun.new
    testsuiterun.stubs(:status => 'running')
    show_steplink?(testsuiterun).should be_true
  end
end
