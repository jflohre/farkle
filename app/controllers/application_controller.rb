class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def reset
    @game.preferences[:scoring_dice] = []
    @game.preferences[:scoring_dice1] = []
    @game.preferences[:scoring_dice2] = []
    @game.preferences[:dice] = []
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

end
