Feature: Login
As an admin
I want the website to have a login capability
So that only certain users can see certain parts of the website

Scenario: User visits the website for the first time
When I am not logged in and I visit the homepage
Then I should see the link to login

Scenario: User has logged in and visits a page
When I am logged in and visit the homepage
Then I should see the link to signout