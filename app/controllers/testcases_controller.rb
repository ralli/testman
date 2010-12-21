class TestcasesController < ApplicationController
  filter_resource_access
  
  def index
    @testcases = Testcase.order(:id).paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @testcase = Testcase.find(params[:id])
  end
  
  def new
    @testcase = Testcase.new_with_defaults
  end
  
  def create
    @testcase = Testcase.new(params[:testcase])
    if @testcase.save
      flash[:notice] = "Successfully created testcase."
      redirect_to @testcase
    else
      render :action => 'new'
    end
  end
  
  def edit
    @testcase = Testcase.find(params[:id])
  end
  
  def update
    @testcase = Testcase.find(params[:id])
    if @testcase.update_attributes(params[:testcase])
      flash[:notice] = "Successfully updated testcase."
      redirect_to @testcase
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @testcase = Testcase.find(params[:id])
    @testcase.destroy
    flash[:notice] = "Successfully destroyed testcase."
    redirect_to testcases_url
  end
end
