Feature: Search User by Username
	Everybody can search for another user by typing part of its username,if there any match it will show a link to the searched user's profile page
Background:
	Given a user with username "gabrinca01" 
	And a user with username "blackeyes"
Scenario: gabrinca01 tries to search for blackeyes
	Given I am the user with username "gabrinca01"
	And I am in the home page
	When I fill the search form with "blac"
	And I click on "Search"
	Then I should see the link to user "blackeyes" on the page

Scenario: blackeyes tries to follow gabrinca01 after searching him
	Given I am the user with username "blackeyes"
	And I am in the profile page of gabrinca01
	When I click on "Follow"
	Then I should see the link to "Unfollow"