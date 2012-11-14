Feature: Booking an Opportunity
  As a user
  Booking opportunites

  Scenario: Contacting an author
    Given I am signed in with a valid user
    And there is an opportunity available
    And I am on the opportunities page
    And I click the "Contact" link
    And I fill in the fields
      | Message: | Hello, this is a message |
    And I click the send button
    Then the message should be sent

  @wip
  Scenario: Booking an opportunity
    Given I am signed in as a user that has authored an opportunity
    And A user has contacted me about that opportunity
    And I am on the index page
    And I click the "Authored" link
    And I click the "Messages" icon
    And I click the "Book them" button
    Then I should be on the conversation page
    And the opportunity should be booked

  @wip
  Scenario: Booked opportunites are listed
    Given I am signed in with a valid user
    And I have been booked for an opportunity
    And I am on the index page
    And I click the "Booked" link
    And I click the "Conversation" icon
    Then I should be on the booked opportunity page
