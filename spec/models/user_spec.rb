require 'spec_helper'

describe User do
  subject { User.make_unsaved }

  context "when validating" do
    it { should be_valid }
    it { should validate_presence_of :login }
    it { should ensure_length_of(:login).is_at_most(20) }
    it { should validate_presence_of :email }
    it { should ensure_length_of(:email).is_at_most(80) }
  end

  context "when getting the display name" do
    it "should return the login if the first name is blank" do
      subject.first_name = nil
      subject.display_name.should == subject.login
    end

    it "should return the login if the last name is blank" do
      subject.last_name = nil
      subject.display_name.should == subject.login
    end

    it "should return the first and last name if both is given" do
      subject.display_name.should == "#{subject.first_name} #{subject.last_name}"
    end

    it "should have the same label in list boxes as its display name" do
      subject.to_label.should == subject.display_name
    end
  end

  it "should have administration permissions" do
    subject.role_symbols.should include(:admin)
  end
end

