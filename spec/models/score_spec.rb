require 'spec_helper'

describe Score do
  let(:score) { score = Score.new}
  it 'should be return a new score' do
    score.should be_an_instance_of Score
  end
#Testing ones  
  it "should create a score of 100 for three 1s" do
    score.score_ones([1,1,1]).should == 1000
  end
  it "should create a score of 1100 for four 1s" do
    score.score_ones([1,1,1,1]).should == 1100
  end
  it "should create a score of 100 for one 1s" do
    score.score_ones([1]).should == 100
  end
#Testing twos  
  it "should create a score of 200 for three 2s" do
    score.score_twos([2,2,2]).should == 200
  end
  it "should create a score of 200 for four 2s" do
    score.score_twos([2,2,2,2]).should == 200
  end
  it "should create a score of 0 for one 2" do
    score.score_twos([2]).should == 0
  end
#Testing threes  
  it "should create a score of 300 for three 3s" do
    score.score_threes([3,3,3]).should == 300
  end
  it "should create a score of 200 for four 2s" do
    score.score_threes([3,3,3,3]).should == 300
  end
  it "should create a score of 0 for one 2" do
    score.score_threes([3]).should == 0
  end
#Testing fours    
  it "should create a score of 400 for three 4s" do
    score.score_fours([4,4,4]).should == 400
  end
  it "should create a score of 400 for four 4s" do
    score.score_fours([4,4,4,4]).should == 400
  end
  it "should create a score of 0 for one 4" do
    score.score_fours([4]).should == 0
  end
#Testing fives    
  it "should create a score of 500 for three 5s" do
    score.score_fives([5,5,5]).should == 500
  end
  it "should create a score of 550 for four 5s" do
    score.score_fives([5,5,5,5]).should == 550
  end
  it "should create a score of 50 for one 5" do
    score.score_fives([5]).should == 50
  end
#Testing sixes    
  it "should create a score of 600 for three 6s" do
    score.score_sixes([6,6,6]).should == 600
  end
  it "should create a score of 600 for four 6s" do
    score.score_sixes([6,6,6,6]).should == 600
  end
  it "should create a score of 0 for one 6" do
    score.score_sixes([6]).should == 0
  end
#Testing group sets  
  it "should create a score of 150 for [1,2,3,4,5,6]" do
    score.round_score([1,2,3,4,5,6]).should == 150
  end
  it "should create a score of 1050 for [1,1,1,4,5,6]" do
    score.round_score([1,1,1,4,5,6]).should == 1050
  end
  it "should create a score of 450 for [1,2,3,4,5,6]" do
    score.round_score([1,3,3,3,5,6]).should == 450
  end
  it "should create a score of 600 for [1,2,3,4,5,6]" do
    score.round_score([1,2,5,5,5,6]).should == 600
  end
  it "should create a score of 700 for [1,2,3,4,5,6]" do
    score.round_score([1,2,3,6,6,6]).should == 700
  end

  it "should create a score of 700 for [5,1,1,1,6,3]" do
    score.round_score([5,1,1,1,6,3]).should == 1050
  end
  it "should create a score of 700 for [1,4,5,5,2,4]" do
    score.round_score([1,4,5,5,2,4]).should == 200
  end
  it "should create a score of 700 for [1,2,3,4,5,6]" do
    score.round_score([1,1,1,5,2,3]).should == 1050
  end
end
