require 'spec_helper'

describe Testcaselog do
  let(:testcaserun) { mock_model(Testcaserun) }
  let(:user) { mock_model(User) }
  subject { Testcaselog.make(:created_by => user, :testcaserun => testcaserun)}

  it { should belong_to :created_by }
  it { should belong_to :testcaserun }

  context "when validating" do
    it { should be_valid }
    it { should validate_presence_of(:testcaserun)}
    it { should validate_presence_of(:created_by)}
  end
end

