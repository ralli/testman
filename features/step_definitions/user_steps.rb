Given /^there exists no User$/ do
  User.delete(:all)
end

Then /^there exists (\d+) User\.$/ do |count|
  User.count == count.to_i
end
