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