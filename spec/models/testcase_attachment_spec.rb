require 'spec_helper'

describe TestcaseAttachment do
  subject { TestcaseAttachment.make }
  it { should belong_to :testcase }
end
