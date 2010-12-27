class TestsuiteEntriesController < ApplicationController
  def destroy
    testsuite = Testsuite.find(params[:testsuite_id])
    entry = TestsuiteEntry.find(params[:id])
    entry.destroy
    redirect_to testsuite, :notice => 'Successfully removed testcase from testsuite.'
  end
end
