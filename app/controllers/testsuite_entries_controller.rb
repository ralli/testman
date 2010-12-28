class TestsuiteEntriesController < ApplicationController
  def destroy
    testsuite = Testsuite.find(params[:testsuite_id])
    entry = TestsuiteEntry.find(params[:id])
    entry.destroy
    redirect_to testsuite, :notice => 'Successfully removed the Testcase from the Testsuite.'
  end

  def move_up
    TestsuiteEntry.transaction do
      @testsuite = Testsuite.find(params[:testsuite_id])
      @entry = TestsuiteEntry.find(params[:id])
      @entry.move_higher
      @testsuite.edited_by = current_user
      @testsuite.save
    end
    redirect_to @testsuite, :notice => 'Moved Testcase up'
  end

  def move_down
    TestsuiteEntry.transaction do
      @testsuite = Testsuite.find(params[:testsuite_id])
      @entry = TestsuiteEntry.find(params[:id])
      @entry.move_lower
      @testsuite.edited_by = current_user
      @testsuite.save
    end
    redirect_to @testsuite, :notice => 'Moved Testcase down'
  end
end
