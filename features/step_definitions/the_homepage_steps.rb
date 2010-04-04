Given /^the following the_homepages:$/ do |the_homepages|
  TheHomepage.create!(the_homepages.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) the_homepage$/ do |pos|
  visit the_homepages_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following the_homepages:$/ do |expected_the_homepages_table|
  expected_the_homepages_table.diff!(tableish('table tr', 'td,th'))
end
