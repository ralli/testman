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
      redirect_to @testcase, :notice => 'Successfully created test step.'
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
      redirect_to @testcase, :notice => 'Successfully updated test step.'
    else
      render 'edit'
    end
  end

  def destroy
    @testcase = Testcase.find(params[:testcase_id])
    @teststep = Teststep.find(params[:id])
    @teststep.destroy
    redirect_to @testcase, :notice => 'Successfully deleted test step.'
  end
end
