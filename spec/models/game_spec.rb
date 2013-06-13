require 'spec_helper'

describe Game do
  let(:game) { game = Game.new}
  it 'should be return a new game' do
    game.should be_an_instance_of Game
  end
#testing for not high enough scores  
  it 'should return false for a score of 500' do
    game.winner?(500).should == false
  end
  it 'should return false for a score of 9999' do
    game.winner?(9999).should == false
  end

#Testing for high enough scores 
  it 'should return true for a score of 10000' do
    game.winner?(10000).should == true
  end
  it 'should return true for a score of 11000' do
    game.winner?(10000).should == true
  end
end
