require 'machinist/active_record'
require 'faker'

Project.blueprint do
  name { Faker::Lorem.words(3).join(" ") }
end