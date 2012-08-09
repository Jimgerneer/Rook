Feature: User login

  Scenario: Creating a user
    Given I am on the signup page
    And I fill in the fields
      | Username: | Decoy2 |
      | Email: | ink2@me.com |
      | Password: | foobar |
      | Confirm: | foobar |
    And I click the submit button
    Then I should have signed up
    And I should be on "/user"

  Scenario: Try to login with invalid user 
    Given I am on the login page
    And I try to log in with an uncreated user
    Then I should be on "/login"
