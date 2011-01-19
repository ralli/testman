class TestsuiterunsController < ApplicationController
  before_filter :check_current_project
  filter_resource_access
  filter_access_to :step_ok, :require => :update
  filter_access_to :step_failure, :require => :update
  filter_access_to :show_all, :require => :update
  filter_access_to :show_current, :require => :update
  filter_access_to :set_all_ok, :require => :update
  filter_access_to :set_all_failed, :require => :update
  
  def index
    @testruns = current_project.testsuiteruns.includes(:testsuite).order("testsuites.key").paginate(:page => params[:page])
  end

  def show
    fetch_testrun
    fetch_teststep_counts
  end

  def show_all
    fetch_testrun
    @testrun.update_attribute('show_mode', 'all')
    redirect_to @testrun
  end

  def show_current
    fetch_testrun
    @testrun.update_attribute('show_mode', 'current')
    redirect_to @testrun
  end

  def set_all_ok
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.set_all(current_user, 'ok')
    end
    redirect_to @testrun
  end

  def set_all_failed
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.set_all(current_user, 'ok')
    end
    redirect_to @testrun
  end

  def step_ok
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.step(current_user, "ok")
    end
    redirect_to @testrun
  end


  def step_failure
    Testsuiterun.transaction do
      fetch_testrun
      @testrun.step(current_user, "failed")
    end
    redirect_to @testrun
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
