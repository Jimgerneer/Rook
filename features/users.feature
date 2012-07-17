Feature: Managing Users

  Scenario: Creating a Users
    When I create a user:
      | username | email      | password | password_confirmation |
      | decoy    | ink@me.com | foobar   | foobar                |
    Then I should have the following user:
      | username |
      | decoy |
