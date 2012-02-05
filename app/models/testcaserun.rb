class Testcaserun < ActiveRecord::Base
  belongs_to :testsuiterun
  validates_presence_of :testsuiterun

  belongs_to :testcase
  validates_presence_of :testcase

  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by

  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by

  validates_presence_of :status
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']

  validates_presence_of :result
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']

  has_many :teststepruns, :dependent => :destroy, :order => 'position'
  has_many :testcaselogs, :dependent => :destroy, :order => 'created_at'

  has_many :bug_reports, :dependent => :destroy

  after_create :create_log

  def nextstep
    teststepruns.where(["status <> ?", 'ended']).first
  end

  def next?
    not nextstep.nil?
  end

  def step?
    status != 'ended'
  end

  def step(user, result)
    return nil unless step?

    s = nextstep
    if s.nil? then
      update_status(user, 'ended', result)
      return nil
    end

    s.step(user, result)
    if nextstep.nil? then
      update_status(user, 'ended', result)
    end
    s
  end

  def set_all(user, result)
    teststepruns.each do |run|
      run.status = 'ended'
      run.result = result
      run.save!
    end
    self.status = 'ended'
    self.result = result
    save!
    create_log
  end

  def testcasecount
    testsuiterun.try(:testcaseruns).try(:count) || 0
  end

  def latest_status_update
    result = testcaselogs.last.try(:created_at)
    result = updated_at if result.nil?
    result
  end

  private
  def create_log
    Testcaselog.create!(:created_by => created_by, :testcaserun => self, :status => status, :result => result)
  end

  def update_status(user, status, result)
    self.edited_by = user
    self.status = status
    self.result = result
    save!
    testcaselogs.create!(:created_by => user, :status => status, :result => result)
  end
end

