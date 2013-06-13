class Game < ActiveRecord::Base
  serialize :preferences

  attr_accessible :winner, :players, :preferences
  has_many :players

  def winner?(score)
    if score >= 10000
      true
    else
     false
    end
  end

end
