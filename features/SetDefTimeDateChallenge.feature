Feature: Set Definite Time/Date/Duration of Challenge
	Only the creator of the challenge can set the definite time/date/duration
	And he can do it only once  
Background:
	Given a user with username "gabrinca01" 
	And a challenge called "Let's clean that park" with no definite setted date/time/duration and "gabrinca01" as creator
	And a user who joined the challenge called "Let's clean the park" with username "blackeyes"
Scenario: gabrinca01 tries to set the definite date/time/duration of a challenge
	Given I am the user with username "gabrinca01"
	And I am in the chat page of the challenge Let's clean that park
	When I click on "Set Date/Time/Duration"
	Then I should be on the update page of that challenge

Scenario: blackeyes tries to send a message in the chat
	Given I am the user with username "blackeyes"
	And I am in the chat page of the challenge Let's clean that park
	When I fill the message form with "Ciao ragazzi"
	And I click on "Send"
	Then I should see the message "Ciao ragazzi" on the chat



