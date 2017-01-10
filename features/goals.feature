Feature: Create and approve goals
    In order to use the goals feature
    A user
    Should be able to create and approve goals
 
    Scenario: A manager creates a goal for a user and the goal's whole lifecycle is tested
        Given a manager account and a user account already exist
        When I am in the manager's browser
        And I am logged in as the manager
        And I visit the employee's goals page
        And I click "ADD A NEW GOAL"
        And I fill in "What's your goal?" with "Sample testing goal"
        And I click the datepicker input box
        And I click a date
        When I press "CREATE GOAL"
        Then page should have notice message "Goal was successfully created."

        When I am in the employee's browser
        And I am logged in as the employee
        And I visit my goals page
        And I click on the goal named "Sample testing goal"
        And I click "APPROVE GOAL"
        Then page should have notice message "Goal approved"

        When I visit my goals page
        And I click on the goal named "Sample testing goal"
        And I fill in "Self Evaluation" with "Sample self eval"
        And I press "SUBMIT"
        Then page should have notice message "Goal was successfully updated."

        When I am in the manager's browser
        And I visit the employee's goals page
        And I click on the goal named "Sample testing goal"
        And I fill in "Manager Evaluation" with "Sample manager eval"
        And I click "Progress"
        And I click "Completed"
        And I press "SUBMIT"
        Then page should have notice message "Goal was successfully updated."

        When I am in the employee's browser
        And I visit my goals page
        And I click on the goal named "Sample testing goal"
        And I click "SIGN OFF"
        Then page should have notice message "Goal signed off"