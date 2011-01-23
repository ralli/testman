require File.dirname(__FILE__) + '/../spec_helper'

describe Testcase do
  def make_unsaved_testcase(attributes = {})
    project = Project.make
    user = User.make
    Testcase.make_unsaved(attributes.merge({:key => 'NEW', :project => project, :created_by => user, :edited_by => user }))
  end

  describe "validations" do
    it "should be valid" do
      testcase = make_unsaved_testcase
      puts testcase.errors.inspect unless testcase.valid?
      testcase.should be_valid
    end

    def self.check_invalid_value(attribute)
      it "should not be valid if an invalid #{attribute.to_s} given" do
        make_unsaved_testcase(attribute => 'invalid').should_not be_valid
      end
    end

    check_invalid_value(:test_area)
    check_invalid_value(:test_variety)
    check_invalid_value(:test_level)
    check_invalid_value(:execution_type)
    check_invalid_value(:test_status)
    check_invalid_value(:test_priority)
    check_invalid_value(:test_method)
  end

  describe "when creating a new version" do
    before :all do
      @testcase = Testcase.make(:full)
      #      @testcase.teststeps << Teststep.make(:testcase => @testcase)
      @testcase.teststeps.make()
      attachment = @testcase.testcase_attachments.create(:attachment => File.join(Rails.root, 'spec', 'fixtures', 'testfile.txt'))
      @copy = @testcase.create_version
    end
    
    after :all do
      @testcase.destroy
      @copy.destroy
    end

    it "should have the same attributes as its original" do
      @testcase.attributes.each do |key, value|
        @copy.attributes[key].should== value unless key == 'version' or key == 'created_at' or key == 'updated_at' or key == 'id'
      end
    end
    
    it "should have a different id than its original" do
      @testcase.id.should_not== @copy.id
    end

    it "should have a new version" do
      @copy.version.should== @testcase.version + 1
    end

    it "should copy its teststeps as well" do
      @copy.teststeps.size.should== 1
      @testcase.teststeps.each_with_index do |step,idx|
        step_copy = @copy.teststeps[idx]
        step_copy.step.should== step.step
        step_copy.expected_result.should== step.expected_result
        step_copy.id.should_not== step.id
      end
    end
    
    it "should copy its attachments as well" do
      @copy.testcase_attachments.size.should== 1
    end
  end

  describe "when searching" do
    it "should find a text within its name" do
      @testcase = Testcase.make(:name => 'King of the Bongo la la')
      @result = Testcase.search('bongo')
      @result.size.should== 1
    end
    
    it "should find a text within its description" do
      @testcase = Testcase.make(:description => 'King of the Bongo la la')
      @result = Testcase.search('bongo')
      @result.size.should== 1
    end
    
    it "should find a text within the teststeps step-definition" do
      @testcase = Testcase.make
      @teststep = @testcase.teststeps.make(:step => 'King of the Bongo la la')
      @result = Testcase.search('bongo')
      @result.size.should== 1
    end
    
    it "should find a text within the teststeps expected outcome" do
      @testcase = Testcase.make
      @teststep = @testcase.teststeps.make(:expected_result => 'King of the Bongo la la')
      @result = Testcase.search('bongo')
      @result.size.should== 1
    end
  end
end
