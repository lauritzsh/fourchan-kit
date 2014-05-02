Then /^the following folders should exist:$/ do |folders|
  folders = folders.raw.flatten
  folders.each { |f| File.exists?(f).should == true }
end

And /^the following folders should have "(\d+)" files combined:$/ do |count, folders|
  folders = folders.raw.flatten
  files   = 0
  folders.each { |f| files += Dir["#{f}/**/*"].length }
  files.should == count.to_i
end
