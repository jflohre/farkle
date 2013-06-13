class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def reset
    @game.preferences[:scoring_dice] = []
    @game.preferences[:scoring_dice1] = []
    @game.preferences[:scoring_dice2] = []
    @game.preferences[:dice] = []
  end
  def current_player
    @game.preferences[:current_player]
  end
  def current_score
    if @game.preferences[:scoring_dice2].present?
      score3 = Score.new.round_score(@game.preferences[:scoring_dice2])
      score2 = Score.new.round_score(@game.preferences[:scoring_dice1])
      score = Score.new.round_score(@game.preferences[:scoring_dice])
      current_score = score + score2 + score3
    elsif @game.preferences[:scoring_dice1].present? 
      score2 = Score.new.round_score(@game.preferences[:scoring_dice1])
      score = Score.new.round_score(@game.preferences[:scoring_dice])
      current_score = score + score2
    else @game.preferences[:scoring_dice].present?
      score = Score.new.round_score(@game.preferences[:scoring_dice])
      current_score = score
    end
  end
  def placing_dice_in_scoring_dice
    index = params[:die].to_i
    @dice = @game.preferences[:dice]
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
  end
end
