require 'spec_helper'

describe Teststeprun do
  let(:teststep) { mock_model(Teststep) }
  let(:testcaserun) { mock_model(Testcaserun) }
  let(:user) { mock_model(User) }
  subject { Teststeprun.make(:teststep => teststep, :testcaserun => testcaserun, :created_by => user, :edited_by => user) }

  context "when validating" do
    it "should be valid" do
      subject.should be_valid
    end

    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:result) }
    it { should validate_presence_of(:teststep) }
    it { should validate_presence_of(:testcaserun) }
    it { should validate_presence_of(:created_by) }
    it { should validate_presence_of(:edited_by) }

    it "should have a valid status" do
      subject.status = 'hase'
      subject.should_not be_valid
    end

    it "should have a valid result" do
      subject.result = 'hase'
      subject.should_not be_valid
    end
  end

  context "when stepping" do
    it "should not step if status is ended" do
      subject.status = 'ended'
      subject.result = 'ok'
      subject.step?.should be_false
    end

    it "should step if status is running" do
      subject.status = 'running'
      subject.result = 'unknown'
      subject.step?.should be_true
    end

    it "should step ok" do
      subject.status = 'running'
      subject.result = 'unknown'
      subject.should_receive(:update_attributes!).with(:edited_by => user, :status  => 'ended', :result => 'ok')
      subject.step(user, 'ok')
    end
  end
end

