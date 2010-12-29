require 'spec_helper'

describe Teststeprun do
  def make_valid_testrun(attributes = {})
    teststep = Teststep.new
    teststep.stubs(Teststep.plan)
    testcaserun = Testcaserun.new
    testcaserun.stubs(Testcaserun.plan)
    Teststeprun.make_unsaved(Teststeprun.plan.merge(:teststep => teststep, :testcaserun => testcaserun).merge(attributes))
  end

  it "should be valid" do
    run = make_valid_testrun
    run.should be_valid
  end

  it "should have a status" do
    run = make_valid_testrun(:status => nil)
    run.should_not be_valid
  end

  it "should have a result" do
    run = make_valid_testrun(:result => nil)
    run.should_not be_valid
  end

  it "should have a valid status" do
    run = make_valid_testrun(:status => 'hase')
    run.should_not be_valid
  end

  it "should have a valid result" do
    run = make_valid_testrun(:result => 'hase')
    run.should_not be_valid
  end

  it "should belong to a test step" do
    run = make_valid_testrun(:teststep => nil)
    run.should_not be_valid
  end

  it "should belong to a testcase run" do
    run = make_valid_testrun(:testcaserun => nil)
    run.should_not be_valid
  end
end
