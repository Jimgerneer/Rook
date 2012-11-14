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
    Then I should be on "/beta"
