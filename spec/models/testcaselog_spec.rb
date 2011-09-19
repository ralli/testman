require 'spec_helper'

describe Testcaselog do
  context "when validating" do
    let(:testcaserun) { mock_model(Testcaserun) }
    let(:user) { mock_model(User) }
    subject { Testcaselog.make_unsaved(:created_by => user, :testcaserun => testcaserun)}

    it { should be_valid }
  end
end

