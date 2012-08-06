Feature: Booking an Opportunity
  As a user
  I want to book an opportunity

  Scenario: Booking an opportunity
    Given I am viewing "/login"
    And I sign in as "DecoyDrone"
    And there is an opportunity available
    And I am on the opportunities page
    And I click the "Book it" button
    Then the opportunity should be booked
    Then I should be on the user page
