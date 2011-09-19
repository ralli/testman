require 'spec_helper'

describe TestcaseAttachmentsController do
  let(:testcase) { mock_model(Testcase).as_null_object }
  let(:testcase_attachment) { mock_model(TestcaseAttachment, :testcase => testcase).as_null_object }

  before do
    Testcase.stub(:find).with(testcase.to_param) { testcase }
  end

  describe "GET new" do
    before do
      TestcaseAttachment.stub(:new) { testcase_attachment }
    end

    it "should assign testcase and testcase attachment" do
      get :new, :testcase_id => testcase.to_param
      assigns(:testcase).should == testcase
      assigns(:testcase_attachment).should == testcase_attachment
    end
  end

  describe "POST create" do
    before do
      TestcaseAttachment.stub(:new) { testcase_attachment }
    end

    context "when validation fails" do
      it "should render the new template" do
        testcase_attachment.stub(:save) { false }
        post :create, :testcase_id => testcase.to_param, :testcase_attachment => { :bla => 'xxx' }
        response.should render_template 'new'
      end

      it "should assign an error message" do
        testcase_attachment.stub(:save) { false }
        post :create, :testcase_id => testcase.to_param, :testcase_attachment => { :bla => 'xxx' }
        flash[:error].should_not be_nil
      end
    end

    context "when validation succeeds" do
      it "should redirect to the testcases page" do
        testcase_attachment.stub(:save) { true }
        post :create, :testcase_id => testcase.to_param, :testcase_attachment => { :bla => 'xxx' }
        response.should redirect_to(testcase)
      end

      it "should assign a success message" do
        testcase_attachment.stub(:save) { true }
        post :create, :testcase_id => testcase.to_param, :testcase_attachment => { :bla => 'xxx' }
        flash[:notice].should_not be_nil
      end
    end
  end

  describe "DELETE destroy" do
    before do
      TestcaseAttachment.stub(:find).with(testcase_attachment.to_param) { testcase_attachment }
    end

    it "should destroy the attachment" do
      delete :destroy, :testcase_id => testcase.to_param, :id => testcase_attachment.to_param
      testcase_attachment.expect(:destroy)
    end

    it "should redirect to the testcases page" do
      delete :destroy, :testcase_id => testcase.to_param, :id => testcase_attachment.to_param
      response.should redirect_to(testcase)
    end

    it "should assign a success message" do
      delete :destroy, :testcase_id => testcase.to_param, :id => testcase_attachment.to_param
      flash[:notice].should_not be_nil
    end
  end
end

