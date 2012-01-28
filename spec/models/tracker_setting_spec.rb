require 'spec_helper'

describe TrackerSetting do
  subject { RedmineSetting.make }
  it { should belong_to(:project) }
  it { should validate_presence_of(:project) }

  it { should validate_presence_of :site }
  it { should ensure_length_of(:site).is_at_most(255) }
  it { should ensure_length_of(:user).is_at_most(60) }
  it { should ensure_length_of(:password).is_at_most(60) }

  it { should validate_presence_of(:tracker_project_id)}
  it { should ensure_length_of(:tracker_project_name).is_at_most(255) }
  it { should ensure_length_of(:tracker_project_key).is_at_most(60) }
  it { should_not validate_presence_of(:tracker_project_name)}
  it { should_not validate_presence_of(:tracker_project_key)}
end