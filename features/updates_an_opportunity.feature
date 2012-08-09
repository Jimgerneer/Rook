Feature: Updating an opportunity

  Scenario: Updating an opportunity
    Given I am signed in as a user that has authored an opportunity
    And I am on the update opportunity page
    And I fill in the fields
      | Title: | Ruby the new hope |
      | Skills: | Ruby |
      | Description: | Learn Ruby again |
    And I click the submit button
    Then the opportunity should be updated
