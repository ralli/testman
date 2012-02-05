require 'spec_helper'

describe BugReport do
  let(:testsuiterun) { mock_model(Testsuiterun) }
  subject { BugReport.new(:title => 'title', :message => 'message', :testsuiterun => testsuiterun) }

  it "should be valid with valid attributes given" do
    subject.should be_valid
  end

  it { should belong_to :testsuiterun }
  it { should have_one :testsuite }

  describe "when validating" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(100) }
    it { should validate_presence_of :message }
    it { should validate_presence_of :testsuiterun }
  end
end
