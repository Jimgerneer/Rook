Feature: Closing an Opportunity

  @wip
  Scenario: User closes opportunity
    Given I am signed in with a valid user
    And I am on the create opportunity page
    And I fill in the fields
      | Title:  |  Ruby |
      | Skills: |  Mad  |
      | Description: | Skills |
    And I click the submit button
    And I am on the user page
    And I click the "Close" link
    And I click the "Confirm Close" link
    Then the opportunity should be deactivated
    And I should be on "/"
