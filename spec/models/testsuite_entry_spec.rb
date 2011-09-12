require 'spec_helper'

describe TestsuiteEntry do
  context "when validating" do
    let(:testcase) { mock_model(Testcase) }
    let(:testsuite) { mock_model(Testsuite) }
    subject { TestsuiteEntry.make_unsaved(:testsuite => testsuite, :testcase => testcase) }

    it { should be_valid }
    it { should validate_presence_of :testsuite }
    it { should validate_presence_of :testcase }
  end

end

