Feature: Create feedback
    In order to use the feedback feature
    A user
    Should be able to create feedback

    Scenario: A manager creates feedback for a user
        Given a manager account and a user account already exist
        When I am in the manager's browser
        And I am logged in as the manager
        And I visit the employee's feedback page
        And I click "What's your feedbk?"
        And I fill in "Enter Feedback (150 char. max)" with "Sample testing feedback"
        When I press "CREATE FEEDBACK"
        Then page should have notice message "Feedback was successfully created."

        When I am in the employee's browser
        And I am logged in as the employee
        And I visit my feedback page
        And I click on the reply button for the feedback named "Sample testing feedback"
        And I fill in "Enter Feedback (150 char. max)" with "Sample testing reply"
        When I press "SUBMIT"
        Then page should have notice message "Reply created"
