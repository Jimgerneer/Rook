Feature: Mail

  Scenario: Mail after created opportunity
    Given I have a user "Jim"
    When I create an opportunity:
      | title | skills | description | user |
      | Ruby Lessons | Ruby | This is a course on Ruby | Jim |
    Then an email with the following body should be sent:
      | body |
