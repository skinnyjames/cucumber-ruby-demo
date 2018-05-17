require File.dirname(__FILE__) + '/../../src/search-client.rb'

Given("the user searches google") do
  begin 
    @client = SearchClient.new(%w{cucumber ruby google})
  rescue SearchClientError => e
    @error = e
  end
end

When("the search is successful") do
  expect(@error.nil?).to be true
end

Then("the user should see links") do
  expect(@client.links.length).to be > 0
  expect(@client.to_html).to match /a\shref\='/
end

Given("the user searches google with no input") do 
  begin 
    @client = SearchClient.new([])
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
