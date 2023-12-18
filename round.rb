require_relative 'interface'
# main cycle of game
class Round
  include Interface
  BLACKJACK = 21
  attr_reader :result

  def initialize(player1, player2)
    @player = player1
    @dealer = player2
    @result = nil
    @deck = Deck.new
  end

  def play
    setup_round
    moves
    player_cards(@dealer)
    @result = who_wins
  end

  private

  def setup_round
    deal_cards(@player, 2)
    deal_cards(@dealer, 2)
    player_cards(@player, :open)
    player_cards(@dealer, :hidden)
  end

  def moves
    return if move(@player) == :open
    return if move(@dealer) == :open

    move(@player)
  end

  def move(player)
    return :open if player.hand.cards.size == 3

    decision = player.decision
    return :open if decision == :open

    deal_cards(player, 1) if decision == :take
    Interface.show_decision(player.name, decision)
    type = player.class == Dealer ? :hidden : :show
    player_cards(player, type)
  end

  def who_wins
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья
    score1 = @player.hand.score
    score2 = @dealer.hand.score
    return :both_lost if [score1, score2].min > BLACKJACK

    return @player if score2 > BLACKJACK
    return @dealer if score1 > BLACKJACK
    return @player if BLACKJACK - score1 < BLACKJACK - score2
    return @dealer if BLACKJACK - score1 > BLACKJACK - score2

    :draw
  end

  def deal_cards(player, quantity)
    quantity.times { player.hand.take_card(@deck.deal_card) }
  end

  def player_cards(player, type = :show)
    if type == :hidden
      Interface.show_cards(player.name, player.hand.show_hidden, player.hand.score_hidden)
    else
      Interface.show_cards(player.name, player.hand.show, player.hand.score)
    end
  end
end
