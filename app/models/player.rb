class Player < ActiveRecord::Base
  attr_accessible :name, :score
  belongs_to :game
  after_initialize :init


  def init
    self.score ||= 0
  end

  def add_to_score(round_score)
    self.score += round_score
  end
end
