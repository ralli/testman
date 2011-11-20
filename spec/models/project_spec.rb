require 'spec_helper'

describe Project do
  subject { Project.make_unsaved }

  it { should have_many(:testcases) }
  it { should have_many(:testsuites) }
  it { should have_many(:current_users) }
  it { should have_many(:testsuiteruns) }
  it { should have_many(:testcaseruns) }
  it { should have_many(:teststeps) }

  describe "when validating" do
    it "should be valid" do
      subject.should be_valid
    end

    it { should ensure_length_of(:name).is_at_most(80) }
    it { should validate_presence_of :name }

  end
end

