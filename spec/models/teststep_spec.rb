require 'spec_helper'

describe Teststep do
  let(:testcase) { mock_model(Testcase) }
  let(:user) { mock_model(User) }
  let(:testcaserun) { mock_model(Testcaserun) }
  subject { Teststep.make(:testcase => testcase) }

  context "when validating" do
    it { should be_valid }
    it { should validate_presence_of :step }
    it { should validate_presence_of :expected_result }
  end

  context "when creating a run" do
    it "should not crash" do
      Teststeprun.expects(:create!).with(:created_by => user, :edited_by => user, :testcaserun => testcaserun, :teststep => subject, :status => 'new', :result => 'unknown')
      subject.create_run(user, testcaserun)
    end
  end
end
