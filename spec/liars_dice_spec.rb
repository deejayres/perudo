require_relative '../liars_dice.rb'

RSpec.describe  Game do
  before(:each) do
      @game = Game.new(players: 4)
      @game.players = [
        {:id=>1, :dice_in_hand=>[2, 3, 1, 3, 1]},
        {:id=>2, :dice_in_hand=>[4, 4, 2, 2, 5]},
        {:id=>3, :dice_in_hand=>[3, 6, 4, 6, 4]},
        {:id=>4, :dice_in_hand=>[3, 5, 4, 1, 5]}
      ]
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
    it 'returns the probability that a given bid is correct as a string with no moves made' do
      claim = @game.claim(dice: 5, value: 4)

      expect(claim).to eq("23.13%")
    end

    it 'correctly calculates probability after dice have been played' do
      @game.move(player: 2, dice: 2, value: 4)
      claim = @game.claim(dice: 8, value: 4)

      expect(claim).to eq("6.53%")
    end
  end

  describe '#challenge' do
    it "checks the total dice and returns a boolean response to the challenge's validity" do
      expect(@game.challenge(dice: 5, value: 4)).to eq("Challenge failed! There are 5 4s!")
      expect(@game.challenge(dice: 7, value: 2)).to eq("Challenge stands! There are only 3 2s!")
    end
  end

end
