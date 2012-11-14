Feature: Creating an opportunity
  As a user
  I want to create an opportunity

  Scenario: Creating an opportunity
    Given I am signed in with a valid user
    And I am on the create opportunity page
    And I fill in the fields
      | Title: | Ruby for Beginners |
      | Skills: | Ruby, TDD |
      | Description: | Learn Ruby from the basics |
    And I click the submit button
    Then the opportunity should be created
