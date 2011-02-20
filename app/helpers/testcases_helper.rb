module TestcasesHelper
  def test_areas
    [[t('helpers.test_areas.functional'), 'FUNCTIONAL'],
      [t('helpers.test_areas.non_functional'), 'NON-FUNCTIONAL'],
      [t('helpers.test_areas.structural'), 'STRUCTURAL'],
      [t('helpers.test_areas.regression'), 'REGRESSION'],
      [t('helpers.test_areas.retest'), 'RETEST']]
  end

  def test_varieties
    [[t('helpers.test_varieties.positive'), 'POSITIVE'],
      [t('helpers.test_varieties.negative'), 'NEGATIVE']]
  end

  def test_priorities
    [[t('helpers.test_priorities.low'), 'LOW'],
      [t('helpers.test_priorities.medium'), 'MEDIUM'],
      [t('helpers.test_priorities.high'), 'HIGH']]
  end

  def test_methods
    [[t('helpers.test_methods.black_box'), 'BLACKBOX'],
      [t('helpers.test_methods.white_box'), 'WHITEBOX'],]
  end

  def test_statuses
    [[t('helpers.test_statuses.design'), 'DESIGN'],
      [t('helpers.test_statuses.confirmed'), 'CONFIRMED'],
      [t('helpers.test_statuses.locked'), 'LOCKED'],
      [t('helpers.test_statuses.disabled'), 'DISABLED'],]
  end

  def test_levels
    [[t('helpers.test_levels.component_test'), 'COMPONENT_TEST'],
      [t('helpers.test_levels.system_test'), 'SYSTEM_TEST'],
      [t('helpers.test_levels.integration_test'), 'INTEGRATION_TEST'],
      [t('helpers.test_levels.acceptance_test'), 'ACCEPTANCE_TEST'],]
  end

  def execution_types
    [[t('helpers.execution_types.manual'), 'MANUAL'],
      [t('helpers.execution_types.automatic'), 'AUTOMATIC']]
  end

  def value_for(testcase, attribute)
    key = testcase.send(attribute.to_sym)
    method = attribute.to_s.pluralize.to_sym
    list = self.send(method)
    p = list.detect { |e| e[1] == key }
    p.nil? ? '<Undefined>' :  p[0]
  end

  def keys_for(method)
    list = self.send(method.to_sym)
    list.collect {|item| item[1] }
  end
end

