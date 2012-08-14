Feature: Managing Messages

  Scenario: Creating a Message
    When I create a user:
      | username | email | password | password_confirmation |
      | DecoyDrone | ink@me.com | foobar | foobar |
    And there is another user: 
      | username | email | password | password_confirmation |
      | TheDude | whiterussian@dude.com | rug | rug |
    And I create a message for another user:
      | recipient | sender | body |
      | TheDude | DecoyDrone | I heard you like TDD |
    Then that user should have a message
