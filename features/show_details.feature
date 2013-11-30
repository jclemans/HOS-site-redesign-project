Feature: Deatail page for a show
  In order to get all information about a show
  As a listener
  I want a detail page for each show

  Scenario: Page should render
    Given "Awesome" is a show
    When I go to the show page for "Awesome"
    Then I should see show details for "Awesome"
