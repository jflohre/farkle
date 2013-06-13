class Score < ActiveRecord::Base
  attr_accessible :score

  def score_ones(dice)
    score = 0
    ones = Array.new
    ones = dice - [2,3,4,5,6]
    if ones.length >= 3 
      score += 1000        
      extra_die = ones.length - 3 
      score += extra_die * 100  
    else 
      score = ones.length * 100
    end
  end
  
  def score_twos(dice)
    score = 0
    twos = Array.new
    twos = dice - [1,3,4,5,6]
    if twos.length >= 3
      score += 200
    else 
      score += 0
    end 
  end

  def score_threes(dice)
    score = 0
      threes = Array.new
        threes = dice - [1,2,4,5,6]
      if threes.length >= 3
        score += 300
      else 
        score += 0
      end
  end
  def score_fours(dice)
    score = 0
    fours = Array.new
        fours = dice - [1,2,3,5,6]
      if fours.length >= 3
        score += 400
      else
        score += 0
      end
  end

  def score_fives(dice)
    score = 0
    fives = Array.new
    fives = dice - [1,2,3,4,6]
    if fives.length >= 3
      score += 500
      extra_die = fives.length - 3
      score += extra_die * 50
    else      
      score += fives.length * 50
    end
  end

  def score_sixes(dice)
    score = 0
    sixes = Array.new
    sixes = dice - [1,2,3,4,5]
    if sixes.length >= 3
      score += 600
    else 
      score += 0
    end
  end

  def round_score(dice)
    score = 0
    score += score_ones(dice) + score_twos(dice) + score_threes(dice) +
              score_fours(dice) + score_fives(dice) + score_sixes(dice)
  end

end
