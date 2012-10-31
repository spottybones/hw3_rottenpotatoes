# add movies to database

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

# check the director...
Then /^the director of "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  steps %Q{Given I am on the details page for "#{arg1}"}
  page.should have_xpath('//*', :text => %r{#{arg2}})
end
