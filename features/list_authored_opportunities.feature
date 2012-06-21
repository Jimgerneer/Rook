Feature: List authored opportunities
  As a User
  I want to list opportunities I've authored
  In order to manage created opportunites

  Scenario: Viewing an empty opportunity list
    Given I am logged in
    And I am viewing my user page
    And I have authored no opportunities
    Then the authored opportunity display should be empty

  Scenario: Viewing the opportunity list after new opportunity is created
    Given I am logged in
    And I am viewing my user page
    And I have authored 1 opportunity
    Then the authored opportunity display should have 1 opportunity
