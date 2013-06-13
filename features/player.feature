Feature: Player
  In order to play a game
  As a player
  I want to be able to Start a new game

  Scenario: Home Page
  
    Given I am on the home page
    Then I should see "Welcome to Farkle"
    When I press the button "New Game"
    Then I should see "Player 1's score: 0"
    And I should see "Player 2's score: 0"
    When I press the button "Player 1's turn"
    Then I should see "Roll"
    Then I should see "your current dice: "
    And I should be able to set aside the dice i want to keep
    Then i should be able to choose score_points or roll remaining
    Then it should check to see if there is a winner
    Then it should go to turn page again