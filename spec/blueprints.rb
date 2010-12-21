require 'machinist/active_record'
require 'faker'

Sham.login { Faker::Name.first_name.underscore }

Project.blueprint do
  name { Faker::Lorem.words(3).join(" ") }
end

User.blueprint do
  login
  email { Faker::Internet::email(login) }
  password { login }
  password_confirmation { password }
  first_name { login.camelize }
  last_name { Faker::Name.last_name }
end

Testcase.blueprint do
  version { 1 }
  name { Faker::Lorem.words(4).join(' ') }
  description { Faker::Lorem.sentences(4).join(' ') }
  precondition { Faker::Lorem.sentences(4).join(' ') }
  postcondition { Faker::Lorem.sentences(4).join(' ') }
  expected_result { Faker::Lorem.sentences(4).join(' ') }
  test_area { Testcase.keys_for(:test_areas).rand }
  test_variety { Testcase.keys_for(:test_varieties).rand }
  test_level { Testcase.keys_for(:test_levels).rand }
  execution_type { Testcase.keys_for(:execution_types).rand }
  test_status { Testcase.keys_for(:test_statuses).rand }
  test_priority { Testcase.keys_for(:test_priorities).rand }
  test_method { Testcase.keys_for(:test_methods).rand }
end
