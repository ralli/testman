require 'spec_helper'

describe TestcaseAttachment do
  subject { TestcaseAttachment.make_unsaved }
  it { should belong_to :testcase }
end
