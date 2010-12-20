Given /^there are projects named (.*)$/ do |names|
  nameslist = names.split(",")
  nameslist.each do |name|
    Project.create(:name => name.strip)
  end
end

Given /^there do not exist any projects$/ do
  Project.destroy_all
end

Then /^the number of projects is (\d+)$/ do |count|
  Project.count.should== count.to_i
end
