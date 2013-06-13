class GameController < ApplicationController
  before_filter :set_game, except: [:new, :create, :home]


  def new
    session[:player1] = Player.new(:name => "Player 1", :score => 0)
    session[:player2] = Player.new(:name => "Player 2", :score => 0)
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
    index = params[:die].to_i
    @dice = @game.preferences[:dice]
    # @scoring_dice = @game.preferences[:scoring_dice]
    # @scoring_dice << @dice[index]
    # @dice.delete_at(index)
    # @game.preferences[:dice] = @dice
    # @game.preferences[:scoring_dice] = @scoring_dice
    if @game.preferences[:scoring_dice].count < 6
      @scoring_dice = @game.preferences[:scoring_dice]
      @scoring_dice << @dice[index]
      @dice.delete_at(index)
      @game.preferences[:dice] = @dice
      @game.preferences[:scoring_dice] = @scoring_dice

    elsif @game.preferences[:scoring_dice1].count < 6
      @scoring_dice = @game.preferences[:scoring_dice1]
      @scoring_dice << @dice[index]
      @dice.delete_at(index)
      @game.preferences[:dice] = @dice
      @game.preferences[:scoring_dice1] = @scoring_dice
    else
      @scoring_dice = @game.preferences[:scoring_dice2]
      @scoring_dice << @dice[index]
      @dice.delete_at(index)
      @game.preferences[:dice] = @dice
      @game.preferences[:scoring_dice2] = @scoring_dice
    end
    @game.save
    redirect_to edit_game_path
  end

  def roll_remaining_dice
    if Array(@game.preferences[:dice]) == []
      @dice = 6.times.map {rand(1..6)} #getting a new array of rand
    else 
      @dice = @game.preferences[:dice].length.times.map {rand(1..6)}
    end
    # if current_score = score_with_reroll
    #   @game.preferences[:scoring_dice] = []
    #   @game.preferences[:scoring_dice1] = []
    #   @game.preferences[:scoring_dice2] = []
    #   @game.preferences[:dice] = []
    #   redirect_to game_path
    # else

    @game.preferences[:dice] = @dice 
    @game.save
    redirect_to edit_game_path
  end

  
  def home
  end
  def update
    current_player = @game.players.find(@game.preferences[:current_player])
    # if @game.preferences[:scoring_dice2].present?
    #   score3 = Score.new.round_score(@game.preferences[:scoring_dice2])
    #   score2 = Score.new.round_score(@game.preferences[:scoring_dice1])
    #   score = Score.new.round_score(@game.preferences[:scoring_dice])
    #   current_player.add_to_score(score3)
    #   current_player.add_to_score(score2)
    #   current_player.add_to_score(score)
    # elsif @game.preferences[:scoring_dice1].present? 
    #   score2 = Score.new.round_score(@game.preferences[:scoring_dice1])
    #   score = Score.new.round_score(@game.preferences[:scoring_dice])
    #   current_player.add_to_score(score2)
    #   current_player.add_to_score(score)
    # else @game.preferences[:scoring_dice].present?
    #   score = Score.new.round_score(@game.preferences[:scoring_dice])
    #   current_player.add_to_score(score)
    # end
    score = current_score
    current_player.add_to_score(score)
    reset
    # @game.preferences[:scoring_dice] = []
    # @game.preferences[:scoring_dice1] = []
    # @game.preferences[:scoring_dice2] = []
    # @game.preferences[:dice] = []
    # @game.players.find(@game.preferences[:current_player]).score += score
    # d = params[:dice]
    # @die = session[:die]
    # number_of_dice = @die.count(d.to_i)
    # number_of_dice.times do 
    #   session[:die2] << d.to_i
    # end
    # @die = session[:die].delete(d.to_i)

    # if session[:die2].count >= 6
    #   session[:score] = Score.new.round_score(session[:die2])
    #   session[:die2] = []
    #   @current_player.add_to_score(session[:score])
    # end
    current_player.save!
    @game.save!
    redirect_to @game 
  end



  private
  def set_game
    @game = Game.find(params[:id])
  end

end
