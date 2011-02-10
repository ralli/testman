class TestsuitesController < ApplicationController
  filter_resource_access :additional_member => {:run => :update, :sort_testcases => :update, :show_add => :update, :assign_testcase => :update }
  filter_access_to :remove_testcase, :require => :update
  filter_access_to :search_testcases, :require => :read
  filter_access_to :create_version, :require => :update
  filter_access_to :search, :require => :read

  def index
    @testsuites = current_project.testsuites.paginate(:per_page => 10, :page => params[:page])
  end

  def new
    @testsuite = Testsuite.new_with_defaults
  end

  def create
    @testsuite = Testsuite.new_with_defaults(params[:testsuite])
    @testsuite.project = current_project
    @testsuite.created_by = current_user
    @testsuite.edited_by = current_user
    @testsuite.version = 1
    @testsuite.enabled = true

    if @testsuite.save
      redirect_to @testsuite, :notice => I18n.t('controller.testsuites.successfully_created')
    else
      render 'new'
    end
  end

  def show
    @testsuite = Testsuite.find(params[:id])
    @testsuite_entries = @testsuite.testsuite_entries.includes(:testcase)
  end

  def show_add
    @testsuite = Testsuite.find(params[:id])
    @testsuite_entries = @testsuite.testsuite_entries.includes(:testcase)
    if @testsuite_entries.empty?
      @testcases = current_project.testcases.order("testcases.key")
    else
      @testcases = current_project.testcases.order("testcases.key").where('testcases.id not in (?)', @testsuite.testcases)
    end
  end

  def edit
    @testsuite = Testsuite.find(params[:id])
  end

  def update
    @testsuite = Testsuite.find(params[:id])
    if @testsuite.update_attributes(params[:testsuite])
      redirect_to @testsuite, :notice => I18n.t('controller.testsuites.successfully_updated')
    else
      render 'edit'
    end
  end

  def destroy
    @testsuite = Testsuite.find(params[:id])
    @testsuite.destroy
    redirect_to testsuites_path, :notice => I18n.t('controller.testsuites.successfully_deleted')
  end

  def run
    @testsuite = Testsuite.find(params[:id])
    testsuiterun = @testsuite.create_run(current_user)
    redirect_to testsuiterun, :notice => I18n.t('controller.testsuites.testsuite_run_started')
  end

  def sort_testcases
    @testsuite = Testsuite.find(params[:id])
    ids = params['tctable']
    ids.delete_at(0) unless ids.empty?
    ids.each_with_index do |id, idx|
      TestsuiteEntry.update_all(['position=?', idx+1], ['id=?', id.to_i])
    end
    render :nothing => true
  end

  def assign_testcase
    @testsuite = Testsuite.find(params[:id])
    logger.info(params[:entryid].inspect)
    entry_ids = params[:entryid]
    testcase_id = find_testcase_id(entry_ids)
    logger.info("Testcase Id = #{testcase_id}")
    unless testcase_id.blank? then
      testcase = Testcase.find(testcase_id)
      entry = @testsuite.add_testcase(testcase, current_user)
    else
      entry = nil
    end
    entry_ids.each_with_index do |entry_id, idx|
      match = /^e(\d+)$/.match(entry_id)
      if match
        id = match[1].to_i
      elsif (/^t\d+$/.match(entry_id))
        id = entry.id
      end
      TestsuiteEntry.update_all(['position=?', idx+1], ['id=?', id])
    end
    @testsuite_entries = @testsuite.testsuite_entries(true).includes(:testcase)
    @notice = entry.nil? ? I18n.t('controller.testsuites.successfully_reordered')  : I18n.t('controller.testsuites.successfully_assigned')
  end

  def remove_testcase
    entryid = params[:entryid]
    entry = TestsuiteEntry.find(entryid.to_i)
    entry.destroy()
    @notice = I18n.t('controller.testsuites.successfully_removed_testcase')
  end

  def search_testcases
    param = params[:search] || ""
    if(param.length < 3)
      @testcases = current_project.testcases.order(:id)
    else
      @testcases = Testcase.search(param).where(:project_id => current_project.id)
    end
  end

  def create_version
    @testsuite = Testsuite.find(params[:id])
    Testsuite.transaction do
      @testsuite = @testsuite.create_version(current_user)
    end
    redirect_to @testsuite, :notice => I18n.t('controller.testsuites.new_version_created')
  end

  def search
    q = params[:q]
    if q.blank? then
      @testsuites = Testsuite.order('testsuites.key')
    else
      @testsuites = Testsuite.search(q).where(:project_id => current_project.id).order('testsuites.key')
    end
    @testsuites = @testsuites.paginate(:per_page => 10, :page => params[:page])
    render 'index'
  end

  private

  def find_testcase_id(entry_ids)
    testcase_id = entry_ids.detect(nil) { |id| /^t\d+$/.match(id) }
    return nil if testcase_id.blank?
    match = /^t(\d+)$/.match(testcase_id)
    return match[1].to_i
  end

end

