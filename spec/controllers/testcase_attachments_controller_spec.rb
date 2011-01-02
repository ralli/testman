require File.dirname(__FILE__) + '/../spec_helper'

describe TestcaseAttachmentsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    TestcaseAttachments.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    TestcaseAttachments.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    testcase_attachments = TestcaseAttachments.first
    delete :destroy, :id => testcase_attachments
    response.should redirect_to(root_url)
    TestcaseAttachments.exists?(testcase_attachments.id).should be_false
  end
end
