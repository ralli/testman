Given /^there exists no User$/ do
  User.destroy_all
end

Then /^there exists (\d+) User\.$/ do |count|
  User.count == count.to_i
end
