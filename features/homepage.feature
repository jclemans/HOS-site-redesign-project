Feature: Home page
  In order find out what is happening on the site
  As a listener
  I want to see the homepage

  Scenario: First Impression
    Given I am an unknown user
    When I go to the homepage
    Then I should see a welcome message
