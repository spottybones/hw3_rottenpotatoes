# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body =~ /<td>#{e1}<\/td>.*<td>#{e2}<\/td>/m,
    %Q{Movie "#{e1}" not listed before movie "#{e2}"}
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    steps %Q{When I #{uncheck}check "ratings_#{rating}"}
  end
end

# see, or not, whether the movies with the specified ratings have been returned
Then /I should (not )?see movies with the following ratings: (.*)/ do |knot, rating_list|
  rating_list.split(/,\s*/).each do |rating|
    Movie.find_all_by_rating(rating).each do |movie|
      steps %Q{Then I should #{knot}see "#{movie.title}"}
    end
  end
end

# see all of the movies
Then /I should see all of the movies/ do
  returned_movies_num = page.all("table#movies tbody tr").length
  expected_movies_num = Movie.all.length
  assert returned_movies_num == expected_movies_num,
    "Expected #{expected_movies_num} movies but found #{returned_movies_num}"
end
