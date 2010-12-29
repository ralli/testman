class TestsuiterunsController < ApplicationController
  before_filter :check_current_project
  
  def index
    @testruns = current_project.testsuiteruns.includes(:testsuite).order("testsuites.key").paginate(:page => params[:page])
  end

  def show
    @testrun = Testsuiterun.find(params[:id])
  end
private

  def check_current_project
    if current_project.nil?
      flash[:error] = 'Please select an active project first.'
      redirect_to root_url
    end
  end
end
