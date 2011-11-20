require 'spec_helper'

describe Testcaserun do
  let(:testsuiterun) { mock_model(Testsuiterun) }
  let(:testcase) {mock_model(Testcase) }
  let(:user) { mock_model(User) }
  let(:teststeprun) { mock_model(Teststeprun) }
  let(:testcaselog) { mock_model(Testcaselog) }

  subject { Testcaserun.make_unsaved(:testsuiterun => testsuiterun, :testcase => testcase, :created_by => user, :edited_by => user, :status => 'new', :result => 'unknown') }

  it { should belong_to :testsuiterun }
  it { should belong_to :testcase }
  it { should belong_to :created_by }
  it { should belong_to :edited_by }
  it { should have_many(:teststepruns).dependent(:destroy) }
  it { should have_many(:testcaselogs).dependent(:destroy) }

  context "when validating" do
    it { should be_valid }
    it { should validate_presence_of(:testsuiterun) }
    it { should validate_presence_of(:testcase) }
    it { should validate_presence_of(:created_by) }
    it { should validate_presence_of(:edited_by) }
  end

  context "when stepping" do
    it "should not step if status is ended" do
      subject.status = 'ended'
      subject.step(user, 'ok').should be_nil
    end

    it "should step if status is not ended and a next step exists" do
      subject.teststepruns.stub(:where) { [teststeprun] }
      subject.teststepruns.stub(:where) { [teststeprun] }
      teststeprun.should_receive(:step).with(user, 'ok')
      subject.step(user, 'ok')
      subject.status.should == 'new'
    end

    it "should set the status to ended if there is no next step" do
      subject.teststepruns.stub(:where) { [] }
      subject.teststepruns.stub(:where) { [] }
      subject.step(user, 'ok')
      subject.testcaselogs.stub(:create!)
      subject.status.should == 'ended'
    end

    it "should set the status to ended if there is no next step after stepping" do
      subject.teststepruns.stub(:where) { [teststeprun] }
      subject.teststepruns.stub(:where) { [] }
      subject.step(user, 'ok')
      subject.testcaselogs.stub(:create!)
      subject.status.should == 'ended'
    end
  end

  context "when getting the numbers of testcases" do
    it "returns the number of testcaseruns of its testsuiterun" do
      subject.stub_chain(:testsuiterun,:testcaseruns,:count).and_return(10)
      subject.testcasecount.should == 10
    end
  end

  context "when checking if a next step exists" do
    it "should return true if a next step exists" do
      subject.teststepruns.stub(:where) { [teststeprun] }
      subject.next?.should be_true
    end

    it "should return false if no next step exists" do
      subject.teststepruns.stub(:where) { [] }
      subject.next?.should be_false
    end
  end

  context "when getting the date of the latest status update" do
    let(:testdate) { Date.new(2011, 9, 19)}

    it "should return the creation date of the newest testcaselog if any" do
      subject.stub_chain(:testcaselogs, :last) {testcaselog }
      testcaselog.stub(:created_at) { testdate }
      subject.latest_status_update.should == testdate
    end

    it "should return the update date of the testcaserun if no testcaselog exists" do
      subject.stub(:updated_at) { testdate }
      subject.testcaselogs = []
      subject.latest_status_update.should == testdate
    end
  end
end
