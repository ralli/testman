class ProjectStatistic
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def project_name
    project.name
  end

  def testcase_count
    @testcase_count ||= project.testcases.count
  end

  def testsuite_count
    @testsuite_count ||= project.testsuites.count
  end

  def teststep_count
    @teststep_count ||= project.testcases.joins(:teststeps).count
  end

  def testsuiterun_status_groups
    @testsuiterun_status_groups ||= project.testsuiteruns.group('testsuiteruns.status').count
  end

  def testsuiterun_result_groups
    @testsuiterun_result_groups ||= project.testsuiteruns.group('testsuiteruns.result').count
  end

  def testcaserun_status_groups
    @testcaserun_status_groups ||= project.testcaseruns.group('testcaseruns.status').count
  end

  def testcaserun_result_groups
    @testcaserun_result_groups ||= project.testcaseruns.group('testcaseruns.result').count
  end

  def teststeprun_status_groups
    @teststeprun_status_groups ||= project.testcaseruns.joins(:teststepruns).group('teststepruns.status').count
  end

  def teststeprun_result_groups
    @teststeprun_result_groups ||= project.testcaseruns.joins(:teststepruns).group('teststepruns.result').count
  end

  def testsuiterun_count
    testsuiterun_status_groups.values.sum
  end

  def testcaserun_count
    testcaserun_status_groups.values.sum
  end

  def teststeprun_count
    @teststeprun_count ||= project.testcaseruns.joins(:teststepruns).count
  end

  def result_percentages
    total = teststeprun_count
    total = 1 if total == 0
    teststeprun_result_groups.collect do |k,v|
      [k, ((v.to_f / total.to_f) * 100).round(2)]
    end
  end

  def status_percentages
    total = teststeprun_count
    total = 1 if total == 0
    teststeprun_status_groups.collect do |k,v|
      [k, ((v.to_f / total.to_f) * 100).round(2)]
    end
  end

  def testlog_ended_counts
    return @testlog_ended_counts if @testlog_ended_counts
    fetch_testlog_counts
    return @testlog_ended_counts
  end

  def testlog_new_counts
    return @testlog_new_counts if @testlog_new_counts
    fetch_testlog_counts
    return @testlog_new_counts
  end
private
  def fetch_testlog_counts
    @testlog_ended_counts = get_testlog_counts('ended')
    @testlog_new_counts = get_testlog_counts('new')
  end

  def get_testlog_counts(status)
    date = Date.today - 14.days
    counts = Testcaselog.where('created_at >= ?', date).where('status = ?', status).group('date(created_at)').count.to_a
    a = counts.sort {|a,b| a[0] <=> b[0]}
    c = 0
    a.each do |x|
      x[1] += c
      c = x[1]
    end
    a
  end
end

