Feature: Booking an Opportunity
  As a user
  I want to book a user for my opportunity

  Scenario: Booking an opportunity
    Given I am signed in as a user that has authored an opportunity
    And A user has contacted me about that opportunity
    And I am on the user page
    And I click the "Messages" link
    And I click the "Book them" button
    Then I should be on "/user"
    And the opportunity should be booked
