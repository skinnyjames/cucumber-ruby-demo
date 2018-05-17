Feature: Successful search returns results with links
  Searching a search engine should return links

  Scenario:
    Given the user searches google
    When the search is successful
    Then the user should see links
  Scenario:
    Given the user searches google with no input
    When the search is unsuccessful
    Then the user should get an exception
