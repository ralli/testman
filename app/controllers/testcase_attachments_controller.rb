class TestcaseAttachmentsController < ApplicationController
  def new
    @testcase = Testcase.find(params[:testcase_id])
    @testcase_attachment = TestcaseAttachment.new(:testcase => @testcase)
  end

  def create
    @testcase = Testcase.find(params[:testcase_id])
    @testcase_attachment = TestcaseAttachment.new(params[:testcase_attachment])
    @testcase_attachment.testcase = @testcase
    @testcase_attachment.attachment_content_type = 'text/plain' if @testcase_attachment.attachment_content_type = 'text/html'
    if @testcase_attachment.save
      redirect_to @testcase, :notice => I18n::t('controller.testcase_attachments.successfully_created')
    else
      flash[:error] = I18n::t('controller.testcase_attachments.attachment_required')
      render :action => 'new'
      flash.clear
    end
  end

  def destroy
    @testcase = Testcase.find(params[:testcase_id])
    @testcase_attachment = TestcaseAttachment.find(params[:id])
    @testcase_attachment.destroy
    flash[:notice] = I18n::t('controller.testcase_attachments.successfully_deleted')
    redirect_to @testcase
  end
end

