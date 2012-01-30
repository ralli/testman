require 'spec_helper'

describe BugReport do
  subject { BugReport.new(:title => 'title', :message => 'message')}

  it "should be valid with valid attributes given" do
    subject.should be_valid
  end

  it_should_behave_like "ActiveModel"

  describe "when validating" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(80) }
    it { should validate_presence_of :message }
  end
end
