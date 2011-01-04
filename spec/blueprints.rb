require 'machinist/active_record'
require 'faker'

#Sham.login { Faker::Name.first_name.underscore }

Project.blueprint do
  name { Faker::Lorem.words(3).join(" ") }
end

User.blueprint do
  login { Faker::letterify("??????????") }
  email { Faker::Internet::email(login) }
  password { login }
  password_confirmation { password }
  first_name { login.camelize }
  last_name { Faker::Name.last_name }
end

User.blueprint(:full) do
  current_project { Project.create }
end

Testcase.blueprint do
  version { 1 }
  name { Faker::Lorem.words(4).join(' ') }
  description { Faker::Lorem.sentences(4).join(' ') }
  test_area { Testcase.keys_for(:test_areas).rand }
  test_variety { Testcase.keys_for(:test_varieties).rand }
  test_level { Testcase.keys_for(:test_levels).rand }
  execution_type { Testcase.keys_for(:execution_types).rand }
  test_status { Testcase.keys_for(:test_statuses).rand }
  test_priority { Testcase.keys_for(:test_priorities).rand }
  test_method { Testcase.keys_for(:test_methods).rand }
end

Testcase.blueprint(:full) do
  project { Project.make }
  created_by { User.make(:current_project => project) }
  edited_by { created_by }
end

Teststep.blueprint do
  step { Faker::Lorem.paragraph(3) }
  expected_result { Faker::Lorem.paragraph(3) }
end

Teststep.blueprint(:full) do
  testcase { Testcase.make(:full) }
end

Testsuite.blueprint do
  version { 1 }
  name { Faker::Lorem.sentence(4) }
  description { Faker::Lorem.paragraph(3) }
end

Testsuite.blueprint(:full) do
  project { Project.make }
  created_by { User.make(:current_project => project) }
  edited_by { created_by }
end

TestsuiteEntry.blueprint do
end

Testsuiterun.blueprint do
  status { ['new', 'running', 'ended'].rand }
  result { status != 'ended' ? 'unknown' : ['unknown', 'ok', 'failed', 'error', 'skipped'].rand }
end

Testsuiterun.blueprint(:full) do
  created_by { User.make(:full)}
  edited_by { created_by }
  testsuite { Testsuite.make(:full) }
end

Testcaserun.blueprint do
  status { ['new', 'running', 'ended'].rand }
  result { status != 'ended' ? 'unknown' : ['unknown', 'ok', 'failed', 'error', 'skipped'].rand }
end

Teststeprun.blueprint do
  status { ['new', 'running', 'ended'].rand }
  result { status != 'ended' ? 'unknown' : ['unknown', 'ok', 'failed', 'error', 'skipped'].rand }
end

TestcaseAttachment.blueprint do
  position { 1 }
end