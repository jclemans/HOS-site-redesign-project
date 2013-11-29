Feature: Home page
  In order find out what is happening on the site
  As a listener
  I want to see the homepage

  Scenario: First Impression
    Given I am an unknown user
    When I go to the homepage
    Then I should see a welcome message

  Scenario: Promotes Show Count
    Given I am an unknown user
    And There are 4 active shows
    And There are 2 inactive shows
    When I go to the homepage
    Then I should see that the station has 4 shows
