require 'spec_helper'

describe RedmineSetting do
  let(:project) { mock_model(Project) }
  subject { RedmineSetting.make(:project => project) }

  it { should be_valid }
end