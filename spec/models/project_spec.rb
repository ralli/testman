require 'spec_helper'

describe Project do
  subject { Project.make }

  it { should have_many(:testcases) }
  it { should have_many(:testsuites) }
  it { should have_many(:current_users) }
  it { should have_many(:testsuiteruns) }
  it { should have_many(:testcaseruns) }
  it { should have_many(:teststeps) }
  it "should be valid with valid attributes given" do
    subject.should be_valid
  end
  it { should ensure_length_of(:name).is_at_most(80) }
  it { should validate_presence_of :name }
end

