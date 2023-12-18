class Card
  SUITS = ['♣', '♦', '♥', '♠'].freeze
  RANKS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze

  attr_reader :name, :points

  def initialize(rank, suit)
    @name = "#{rank}#{suit}"
    @points = value(rank)
  end

  private

  def value(rank)
    return 1 if rank == 'A'
    return 10 if rank.is_a?(String)

    rank
  end
end
