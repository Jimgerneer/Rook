Feature: Edit authored opportunities
  As a User
  I want to edit an opportunity I have authored

  Scenario: Edit an authored opportunity
    Given I am logged in
    And I am viewing my user page
    And I have authored 1 opportunity
    And I click "edit"
    And I fill in "Description" with "Long brown dog"
    And I click "save"
    Then I should see "Long brown dog" 


#put update steps all into one package to reduce maintence 
