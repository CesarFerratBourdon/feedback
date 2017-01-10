Feature: Register a user
    In order to use the site
    A visitor
    Should be able to register as a user
 
    Scenario: A company leader comes to the landing page
        Given I am on the landing page
        And I click "SET-UP YOUR TEAM"
        And I fill in "First Name" with "John"
        And I fill in "Last Name" with "Smith"
        And I fill in "Choose a username" with "jsmith"
        And I fill in "Work Email" with "chris+jsmith@cryptographi.com"
        And I fill in "Password" with "muffins1"
        And I fill in "Re-type password" with "muffins1"
        And I fill in "Job Title" with "HR Rep"
        And I fill in "Company or Team Name" with "Meow Co"
        And I press "6-20 Users"
        When I press "SIGN UP"
        Then page should have notice message "You successfully signed up"
        And I attach a photo file to the "user avatar" field
        And I press "SAVE"
        Then page should have notice message "Account successfuly changed"

    Scenario: An employee comes to the landing page
        Given an admin account already exists for the same email domain
        And I am on the landing page
        And I click "JOIN A TEAM"
        And I fill in "First Name" with "Ralph"
        And I fill in "Last Name" with "Wiggum"
        And I fill in "Choose a username" with "rwiggum"
        And I fill in "Work Email" with "chris+rwiggum@cryptographi.com"
        And I fill in "Password" with "muffins1"
        And I fill in "Re-type password" with "muffins1"
        And I fill in "Job Title" with "Manager"
        And I fill in "Your Manager's Email" with "chris+jsmith@cryptographi.com"
        When I press "SIGN UP"
        Then page should have notice message "You successfully signed up"
        And I attach a photo file to the "user avatar" field
        And I press "SAVE"
        Then page should have notice message "Account successfuly changed"