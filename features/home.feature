Feature: view pages

  Scenario: Home page
    Given I am viewing "/"
    Then I should see "Rook"

  Scenario: Visit login
    Given I am viewing "/"
    And I click the "Login" link
    Then I should be on "/login" 

  Scenario: Visit Sign up
    Given I am viewing "/"
    And I click the "Sign-Up" link
    Then I should be on "/signup"

  Scenario: Opportunities paginate
    Given 11 valid opportunites are created
    And I am viewing "/"
    Then I should see "Available Opportunities"
    And there should only be 10 opportunities
