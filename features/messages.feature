Feature: Managing Messages

  Scenario: Creating a Message
    When I create a user:
      | username | email | password | password_confirmation |
      | DecoyDrone | ink@me.com | foobar | foobar |
    And I create a message to myself:
      | recipient | sender | body |
      | DecoyDrone | DecoyDrone | I heard you like TDD |
    Then I should have a message
