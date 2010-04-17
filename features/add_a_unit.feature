Feature: Add a unit
  In order to Add a new Unit
  As a User
  I want follow 3 clicks to add a new unit

  Scenario: add a new unit and first day from the homepage
    Given I am on the home page
    When I follow "Add a Unit"
    And I should see "New Unit"

    When I press "Save"
    Then I should see "Oops! the monkey that was supposed to save your data started flinging poo everywhere!"

    When I fill in "Title" with "Test Unit One"
    And I fill in "Description" with "Description for Test Unit One goes Here"
    And I press "Save"
    Then I should see "Monkey add new Unit"
    And I should see "Test Unit One"
    And I should see "Add your first Day"

    When I follow "Add your first Day"
    Then I should see "Add a new day to Test Unit One"
    And I fill in "Title" with "First Day!"
    And I fill in "Description" with "Description for first day!"
    And I press "Save"
    Then I should see "Monkey add new day"
    And I should see "day #1"
    And I should see "First Day!"
    And I should see "Add a Day"

    When I follow "First Day!"
    Then I should see "Test Unit One"
    And I should see "Description for first day!"
