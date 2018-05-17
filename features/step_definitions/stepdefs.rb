require File.dirname(__FILE__) + '/../../src/search-client.rb'

Given("the user searches google") do
	begin 
		@results = SearchClient.search(%w{cucumber ruby google})
	rescue SearchClientError => e
		@error = e
	end
end

When("the search is successful") do
	expect(@error.nil?).to be true
end

Then("the user should see links") do
	expect(@results.length).to be > 0
end

Given("the user searches google with no input") do 
	begin 
		@results = SearchClient.search([])
	rescue SearchClientError => e
		@error = e
	end
end

When("the search is unsuccessful") do 
  expect(@error.nil?).to be false
end

Then("the user should get an exception") do 
  expect(@error.to_s).to eq('No Results')
end

