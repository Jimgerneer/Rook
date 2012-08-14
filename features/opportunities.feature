Feature: Managing Opportunities

  Scenario: Creating valid Opportunity
    Given I have a user "Jim"
    When I create an opportunity:
      | title         | skills     | description               | user  |
      | Ruby Lessons  | Ruby, TDD  | This is a course on Ruby  | Jim   |
    Then I should have the following opportunities:
      | title |
      | Ruby Lessons |
