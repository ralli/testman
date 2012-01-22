require 'spec_helper'

describe RedmineSetting do
  let(:project) { mock_model(Project) }
  subject { RedmineSetting.make(:project => project) }

  it { should be_valid }

  it { should validate_presence_of :site }
  it { should ensure_length_of(:site).is_at_most(255) }
  it { should ensure_length_of(:user).is_at_most(60) }
  it { should ensure_length_of(:password).is_at_most(60) }
end