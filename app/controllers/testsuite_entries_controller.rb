class TestsuiteEntriesController < ApplicationController
  def destroy
    testsuite = Testsuite.find(params[:testsuite_id])
    entry = TestsuiteEntry.find(params[:id])
    entry.destroy
    redirect_to testsuite, :notice => I18n::t('controller.testsuite_entries.successfully_deleted')
  end
end

