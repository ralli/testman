require 'spec_helper'

describe TestsuiteEntry do
  it "should be valid" do
    suite = Testsuite.make(:full)
    testcase = Testcase.make(:project => suite.project, :created_by => suite.created_by, :edited_by => suite.edited_by)
    entry = TestsuiteEntry.make_unsaved(:testsuite => suite, :testcase => testcase)
    unless entry.valid?
      puts entry.errors.inspect
    end
    entry.should be_valid
  end
end
