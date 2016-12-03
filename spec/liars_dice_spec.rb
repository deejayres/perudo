require_relative '../liars_dice.rb'

RSpec.describe  Game do
  before(:each) do
      @game = Game.new(players: 4)
      @game.players = [{:id=>1, :dice_in_hand=>[2, 3, 1, 3, 1]}, {:id=>2, :dice_in_hand=>[4, 4, 2, 2, 5]}, {:id=>3, :dice_in_hand=>[3, 6, 4, 6, 4]}, {:id=>4, :dice_in_hand=>[3, 5, 4, 1, 5]}]
      @game.unplayed_dice = [2, 3, 1, 3, 1, 4, 4, 2, 2, 5, 3, 6, 4, 6, 4, 3, 5, 4, 1, 5]
  end

  describe '#move' do
    it 'records the bid' do
      @game.move(player: 2, dice: 2, value: 4)

      expect(@game.played_dice).to eq([4, 4])
      expect(@game.unplayed_dice.length).to eq(18)
    end
  end

  describe '#claim' do
    it 'returns the probability that a given bid is correct as a string' do
      claim = @game.claim(20, 5)

      expect(claim).to eq("23.13%")
    end
  end

  describe '#challenge' do
    it "checks the total dice and returns a boolean response to the bid's validity" do
      expect(@game.challenge(dice: 5, value: 4)).to eq("Challenge failed! There are 5 4s!")
      expect(@game.challenge(dice: 7, value: 2)).to eq("Challenge stands! There are only 3 2s!")
    end
  end

end
