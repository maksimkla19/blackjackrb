class Hand
  attr_reader :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def take_card(card)
    @cards << card
    @score = count_points
  end

  def show
    @cards.reduce('') { |acc, card| acc + "#{card.name} " }.lstrip
  end

  def show_hidden
    @cards.reduce('') { |acc, _card| acc + '** ' }.lstrip
  end

  def score_hidden
    'XX'
  end

  def reset
    @cards.clear
    @score = 0
  end

  private

  def count_points
    # туз может равняться 1 или 11 очкам, на выбор игрока, поэтому
    # если есть туз и счёт менее или равен 11, то счёт += 10
    raw = score_raw
    raw += 10 if ace? && raw <= 11
    raw
  end

  def score_raw
    @cards.reduce(0) { |acc, card| acc + card.points }
  end

  def ace?
    !!@cards.detect { |card| card.points == 1 }
  end
end
