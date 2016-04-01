Given /the following movies exist:/ do |movies_table|
    movies_table.hashes.each do |movie|
	Movie.create!(movie)
    end

end


Then /the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
   m = Movie.find_by_title(movie)
   m.director.should == director
   # express the regexp above with the code you wish you had
end

