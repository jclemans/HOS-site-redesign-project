Feature: In order to contact the station
  As a listener
  I want to send an inquiry

  Scenario: Submitting a valid inquiry
    Given I am an unknown user
    And I am on the new inquiry page
    And I fill out the inquiry form correctly
    When I click "Shout Out"
    Then I should see a thank you message

  Scenario: Submitting an invalid inquiry missing email
    Given I am on the new inquiry page
    And I fill out the inquiry form except "email"
    When I click "Shout Out"
    Then I should see an error message

  Scenario: Submitting an invalid inquiry because of bad email
    Given I am on the new inquiry page
    And I fill out the inquiry form with email "aaaaaa"
    When I click "Shout Out"
    Then I should see an error message

  Scenario: Submitting an invalid inquiry missing message
    Given I am on the new inquiry page
    And I fill out the inquiry form except "message"
    When I click "Shout Out"
    Then I should see an error message

  Scenario: Submitting an invalid inquiry missing blue_meanies
    Given I am on the new inquiry page
    And I fill out the inquiry form except "blue_meanies"
    When I click "Shout Out"
    Then I should see an error message





