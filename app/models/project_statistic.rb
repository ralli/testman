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
end

