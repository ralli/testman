require 'spec_helper'

describe TestsuiterunsHelper do
  let(:testcase) { mock_model(Testcase) }
  let(:testsuite) { mock_model(Testsuite) }
  let(:teststep) { mock_model(Teststep) }
  let(:testsuiterun) { mock_model(Testsuiterun) }
  let(:teststeprun) { mock_model(Teststeprun) }
  let(:testcaserun) { mock_model(Testcaserun) }

  it "should respond to nextcase" do
    testsuite.stub(:nextcase) { testcase }
    helper.nextcase(testsuite).should== testcase
  end

  it "should respond to nextstep" do
    testcase.stub(:nextstep) { teststep }
    helper.nextstep(testcase).should== teststep
  end

  it "should not show a step link if status is ended" do
    testsuiterun.stub(:status => 'ended')
    helper.show_steplink?(testsuiterun).should be_false
  end

  it "should show a step link if status is not ended" do
    testsuiterun.stub(:status => 'running')
    helper.show_steplink?(testsuiterun).should be_true
  end

  it "should have a valid label for teststeps" do
    teststep.stub(:position => 1)
    teststeprun.stub(:teststep => teststep, :teststepcount => 10)
    helper.label_for_teststep(teststeprun).should == 'Teststep #1 of 10'
  end

  it "should have a valid label for testcases" do
    testcaserun.stub(:position => 1, :testcasecount => 10, :testsuiterun => testsuiterun)
    helper.label_for_testcase(testcaserun).should== 'Testcase #1 of 10'
  end

  it "should have a valid label for testcases" do
    testcaserun.stub(:position => 1, :testcasecount => 10, :testsuiterun => nil)
    helper.label_for_testcase(testcaserun).should== 'Testcase #1 of 10'
  end
end

