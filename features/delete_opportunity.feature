Feature: Deleting Opportunity

  Scenario: User deletes opportunity
    Given I am signed in with a valid user
    And I am on the create opportunity page
    And I fill in the fields
      | Title:  |  Ruby |
      | Skills: |  Mad  |
      | Description: | Skills |
    And I click the submit button
    And I am on the user page
    And I click the "Delete" link
    And I click the "Confirm" link
    Then the opportunity should be deleted
    And I should be on "/"
