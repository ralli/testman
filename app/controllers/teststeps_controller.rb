class TeststepsController < ApplicationController
  filter_resource_access :nested_in => :testcases

  def new
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.new(:testcase => @testcase)
  end

  def create
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.new(params[:teststep])
    @teststep.testcase = @testcase
    if @teststep.save
      debugger
      unless params[:submit_and_new].blank? then
         redirect_to new_testcase_teststep_path(@testcase), :notice => I18n::t('controller.teststeps.successfully_created')
      else
         redirect_to @testcase, :notice => I18n::t('controller.teststeps.successfully_created')
      end
    else

      render 'new'
    end
  end

  def edit
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.find(params[:id])
  end

  def update
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.find(params[:id])
    if @teststep.update_attributes(params[:teststep])
      redirect_to @testcase, :notice => I18n::t('controller.teststeps.successfully_updated')
    else
      render 'edit'
    end
  end

  def destroy
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.find(params[:id])
    @teststep.destroy
    redirect_to @testcase, :notice => I18n::t('controller.teststeps.successfully_deleted')
  end
end

