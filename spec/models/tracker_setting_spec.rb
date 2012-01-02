require 'spec_helper'

describe TrackerSetting do
  subject { RedmineSetting.make_unsaved }
  it { should belong_to(:project) }
  it { should validate_presence_of(:project) }
end