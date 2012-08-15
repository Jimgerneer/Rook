Feature: Managing Messages

  Scenario: Creating a Message
    When I have a user "Jim"
    And I create an opportunity:
      | title | skills | description | user |
      | Ruby | Ruby, Java | This is a fake | Jim |
    And I create a message to myself:
      | recipient | sender | body |
      | Jim | Jim | I heard you like TDD |
    Then I should have a message
