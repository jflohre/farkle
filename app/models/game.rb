class Game < ActiveRecord::Base
  serialize :preferences

  attr_accessible :winner, :players, :preferences
  has_many :players


end
