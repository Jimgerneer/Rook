Feature: List booked opportunities
  As a User
  I want to list opportunities I've booked
  In order to track booked opportunities

  Scenario: View an empty booked opportunity list
    Given I am logged in
    And I am viewing my user page
    And I have booked no opportunities
    Then the booked opportynity display should be empty

  Scenario: Viewing the opportunity list after an opportunity has been booked
    Given I am logged in
    And I am viewing my user page
    And I have booked 1 opportunity
    Then the booked opportunity display should have 1 opportunity
