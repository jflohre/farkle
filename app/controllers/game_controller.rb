class GameController < ApplicationController
  before_filter :set_game, except: [:new, :create, :home]


  def new
    game = Game.new(:winner => false)
  end
  
  def create
    player1 = Player.create(:name => params[:player1_name])
    player2 = Player.create(:name => params[:player2_name])
    @game = Game.create(players: [player1, player2], :preferences => {dice: [], scoring_dice: [], scoring_dice1: [], scoring_dice2: [] })
    redirect_to @game 
  end

  def edit
    if params[:current_player] != nil
      @game.preferences[:current_player] = params[:current_player]
    end

    if Array(@game.preferences[:dice]) == []
      @dice = 6.times.map {rand(1..6)} #getting a new array of rand
    else 
      @dice = @game.preferences[:dice]
    end
    @dice2 = @game.preferences[:scoring_dice]
    @game.preferences[:dice] = @dice 
    @game.save
  end
  
  def show
    player2 = @game.players.second.id
    player1 = @game.players.first.id
    @player2 = player2.to_i
    @player1 = player1.to_i
  end
  
  def add_to_set
    placing_dice_in_scoring_dice
    @game.save
    redirect_to edit_game_path
  end

  def roll_remaining_dice
    if Array(@game.preferences[:dice]) == []
      @dice = 6.times.map {rand(1..6)} #getting a new array of rand
    else 
      @dice = @game.preferences[:dice].length.times.map {rand(1..6)}
    end
    @game.preferences[:dice] = @dice 
    @game.save
    redirect_to edit_game_path
  end
  
  def final_turn
    if @game.players.first.score >= @game.players.second.score
      @game.preferences[:current_player] = @game.players.second.id
    else 
      @game.preferences[:current_player] = @game.players.first.id
    end

    if Array(@game.preferences[:dice]) == []
      @dice = 6.times.map {rand(1..6)} #getting a new array of rand
    else 
      @dice = @game.preferences[:dice].length.times.map {rand(1..6)}
    end
    @dice2 = @game.preferences[:scoring_dice]
    @game.preferences[:dice] = @dice 
    @game.save
  end

  def farkle
    flash[:notice] = 'Oh no you farkled!'
    reset
    @game.save!
    redirect_to @game
  end

  def winner
    current_player = @game.players.find(@game.preferences[:current_player])
    score = current_score
    current_player.add_to_score(score)
    reset
    current_player.save!
    @game.save!
  end

  def home
  end

  def update
    current_player = @game.players.find(@game.preferences[:current_player])
    score = current_score
    current_player.add_to_score(score)
    reset
    current_player.save!
    if score_amount_meant?(current_player.score)
      flash[:notice] = 'Last chance to get ahead!'
      @game.save!
      redirect_to final_turn_game_path
    else
      @game.save!
      redirect_to @game 
    end
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end
end
