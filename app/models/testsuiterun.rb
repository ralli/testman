class Testsuiterun < ActiveRecord::Base
  belongs_to :testsuite
  validates_presence_of :testsuite

  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']
  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']
  validates_inclusion_of :show_mode, :in => ['all', 'current']

  has_many :testcaseruns, :dependent => :destroy, :order => 'position'
  has_many :teststepruns, :through => :testcaseruns

  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by
  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by

  has_one :project, :through => :testsuite
  has_many :bug_reports, :dependent => :destroy

  def nextcase
    return nil unless step?
    testcaseruns.where(['status <> ?', 'ended']).includes(:testcase).first
  end

  def next?
    not nextcase.nil?
  end

  def step?
    status != 'ended'
  end

  def teststep_count
    teststepruns.count
  end

  def completed_teststep_count
    teststepruns.where('teststepruns.status=?', 'ended').count
  end

  def step(user, result)
    return if status == 'ended'
    c = nextcase
    c.step(user, result) unless c.nil?
    update_attributes!(:edited_by => user, :status => 'ended', :result => result) if nextcase.nil?
  end

  def set_all(user, result)
    testcaseruns.each do |run|
      run.set_all(user, result)
    end
    self.status = 'ended'
    self.result = result
    save!
  end

  def show_all?
    show_mode == 'all'
  end

  def show_current?
    show_mode == 'current'
  end

  def latest_status_update
    result = testcaseruns.collect {|e| e.latest_status_update}.max
    result = updated_at if result.nil?
    result
  end

  def bug_url_for(bug_number)
    self.testsuite.bug_url_for(bug_number)
  end
end

