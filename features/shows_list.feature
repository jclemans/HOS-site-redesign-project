Feature: Show List
  In order to learn about the shows on the site
  As a listener
  I want to see a listing of shows

  Scenario: Seeing Monday's shows
    Given the day is Monday
    And I am an unknown user
    And there are 3 active shows on Monday
    When I go to the programs page
    Then I should see 3 shows

  Scenario: Seeing another days shows
    Given the day is Monday
    And there are 4 active shows on Tuesday
    When I go to the programs page
    And I click on Tuesday in the day nav
    Then I should see 4 shows

  Scenario: Seeing 7 day view of shows
    Given there are 3 active shows on Monday
    And there are 2 active shows on Tuesday
    And there are 4 active shows on Friday
    When I go to the weekly schedule
    Then I should see 9 shows scheduled
