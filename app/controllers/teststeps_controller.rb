class TeststepsController < ApplicationController
  filter_resource_access :nested_in => :testcases, :additional_member => {:move_up => :update, :move_down => :update}
  
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

  def move_up
    Teststep.transaction do
      @testcase = Testcase.find(params[:testcase_id])
      @teststep = Teststep.find(params[:id])
      @teststep.move_higher
      @testcase.edited_by = current_user
      @testcase.updated_at = Time.now
      @testcase.save
    end
    redirect_to @testcase, :notice => 'Teststep moved up'
  end

  def move_down
    Teststep.transaction do
      @testcase = Testcase.find(params[:testcase_id])
      @teststep = Teststep.find(params[:id])
      @teststep.move_lower
      @testcase.edited_by = current_user
      @testcase.updated_at = Time.now
      @testcase.save
    end
    redirect_to @testcase, :notice => 'Teststep moved down'
  end
end
