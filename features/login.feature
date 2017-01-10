Feature: Log in a user
    In order to use the site
    A user
    Should be able to log in
 
    Scenario: An admin comes to the landing page and wants to log in
        Given an admin account already exists for the same email and password
        Given I am on the landing page
        And I click "LOG IN"
        And I fill in "Email address" with "chris+jsmith@cryptographi.com"
        And I fill in "Password" with "muffins1"
        When I press "SUBMIT"
        Then page should have notice message "Signed in successfully."

    Scenario: A manager comes to the landing page and wants to log in
        Given a manager account already exists for the same email and password
        Given I am on the landing page
        And I click "LOG IN"
        And I fill in "Email address" with "chris+rwiggum@cryptographi.com"
        And I fill in "Password" with "muffins1"
        When I press "SUBMIT"
        Then page should have notice message "Signed in successfully."

    Scenario: An employee comes to the landing page and wants to log in
        Given an employee account already exists for the same email and password
        Given I am on the landing page
        And I click "LOG IN"
        And I fill in "Email address" with "chris+nmuntz@cryptographi.com"
        And I fill in "Password" with "muffins1"
        When I press "SUBMIT"
        Then page should have notice message "Signed in successfully."