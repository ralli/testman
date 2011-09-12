require 'spec_helper'

describe Project do
  context "when validating" do
    subject { Project.make_unsaved }

    it "should be valid" do
      subject.should be_valid
    end

    it { should validate_maximum_length_of(:name).to_be(80) }
    it { should validate_presence_of :name }
  end
end

