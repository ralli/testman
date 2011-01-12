class TestsuiterunsController < ApplicationController
  before_filter :check_current_project
  filter_resource_access
  filter_access_to :step_ok => :update
  filter_access_to :step_failure => :update
  
  def index
    @testruns = current_project.testsuiteruns.includes(:testsuite).order("testsuites.key").paginate(:page => params[:page])
  end

  def show
    fetch_testrun
    fetch_teststep_counts
  end

  def step_ok
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.step(current_user, "ok")
      fetch_teststep_counts
    end
    render 'show'
  end


  def step_failure
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.step(current_user, "failed")
      fetch_teststep_counts
    end
    render 'show'      
  end
  
  private
  def check_current_project
    if current_project.nil?
      flash[:error] = 'Please select an active project first.'
      redirect_to root_url
    end
  end

  def fetch_testrun
    @testrun = Testsuiterun.find(params[:id])   
  end

  def fetch_teststep_counts
    @teststep_count = @testrun.teststep_count
    @completed_teststep_count = @testrun.completed_teststep_count
  end
end
