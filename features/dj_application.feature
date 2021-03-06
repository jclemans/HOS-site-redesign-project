Feature: DJ Application
  In order to inquire about becoming a DJ
  As a potential DJ
  I want to submit an application

  Scenario: Successful DJ Application Submission
    Given I am on the new application page
    And I fill out the dj application form correctly
    When I click "SEND"
    Then I should see a thank you message for the dj application

  Scenario: Missing fields
    Given I am on the new application page
    And I fill out the dj application except for "email"
    When I click "SEND"
    Then I should see an error message

  Scenario: Submitting an invalid application missing blue_meanies
    Given I am on the new application page
    And I fill out the dj application except for "blue_meanies"
    When I click "SEND"
    Then I should see an error message

  Scenario: Submitting an invalid application bad blue_meanies
    Given I am on the new application page
    And I fill out the dj application with a "blue_meanies" value of "Black"
    When I click "SEND"
    Then I should see an error message




