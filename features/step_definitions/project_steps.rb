Given /^there are projects named (.*)$/ do |names|
  nameslist = names.split(",")
  nameslist.each do |name|
    Project.create(:name => name.strip)
  end
end
