class Game

  attr_accessor :players, :played_dice, :unplayed_dice, :all_dice

  def initialize(players:)
    @total_dice = players * 5
    @players = []
    create_players(players)
    @unplayed_dice = update_dice
    @played_dice = []
  end

  def move(player:, dice:, value:)
    currentplayer = @players[player - 1]
    currentplayer[:dice_in_hand].reject! { |dice| dice == value }
    currentplayer[:dice_in_hand] = roll(currentplayer[:dice_in_hand].length)
    dice.times { @played_dice << value }
    @unplayed_dice = update_dice
    p "Player #{player} has put #{dice} #{value}s on the board."
  end

  def claim(dice:)
    prob = total_prob(dice)
    percentify(prob)
  end

  def challenge(dice:, value:)
    all_dice = @unplayed_dice + @played_dice
    actual_count = all_dice.count(value)
    actual_count >= dice ? "Challenge failed! There are #{actual_count} #{value}s!" : "Challenge stands! There are only #{actual_count} #{value}s!"
  end

  private

  def create_players(number)
    (1..number).each do |i|
      player = {
        id: i,
        dice_in_hand: roll(5)
      }
      @players << player
    end
  end

  def roll(number)
    dice =[]
    number.times do
      dice << rand(1..6)
    end
    dice
  end

  def update_dice
    @players.inject([]) do |all_dice, player|
      all_dice.concat(player[:dice_in_hand])
    end
  end

  def fac(n)
    if n > 0
      (1..n).reduce(:*)
    else
      1.0
    end
  end

  def single_prob(match)
    (fac(@total_dice) / (fac(match) * fac(@total_dice-match))) * (1.0/6.0) ** match * (5.0/6.0) ** (@total_dice-match)
  end

  def total_prob(match)
    (match..@total_dice).inject(0) do |total, each|
      total += single_prob(each)
    end
  end

  def percentify(prob)
    if prob < 0.0001
      "Less than 0.01%!"
    else
      "#{(prob * 100).round(2)}%"
    end
  end

end
