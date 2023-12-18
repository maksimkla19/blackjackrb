require_relative 'interface'
# main cycle of game
class Game
  include Interface
  attr_reader :player1, :player2, :bet

  def initialize(bank = 100, bet = 10)
    Interface.welcome_message
    @bank_start = bank
    @bet = bet
    @round_counter = 0
    @player1 = Player.new(Interface.name, bank)
    @player2 = Dealer.new('Dealer', bank)
    @players = [@player1, @player2]
  end

  def play
    loop do
      main
      what_next = menu(Interface::GAME_MENU)
      break if what_next == :exit

      reset_cards
    end
    show_final(player1.name, player1.bank - @bank_start)
  end

  private

  def main
    Interface.show_round_welcome(@round_counter += 1)
    @players.each { |pl| Interface.show_status(pl.name, pl.bank) }
    bets_make
    round = Round.new(player1, player2)
    round.play
    check_winner(round.result)
    @players.each { |pl| Interface.show_status(pl.name, pl.bank) }
    check_ruined
  end

  def bets_make
    player1.place_bet(@bet)
    player2.place_bet(@bet)
  end

  def bets_back
    player1.topup_bank(@bet)
    player2.topup_bank(@bet)
  end

  def reset_cards
    player1.hand.reset
    player2.hand.reset
  end

  def check_loser(player)
    player.bank <= 0 ? player : false
  end

  def check_winner(result)
    if result == :draw || result == :both_lost
      Interface.show_draw
      bets_back
    else
      winner = result
      winner.topup_bank(bet * 2)
      Interface.show_winner(winner.name)
    end
  end

  def check_ruined
    ruined = @players.select { |pl| check_loser(pl) }.first
    if ruined
      Interface.show_ruined(ruined.name)
      abort
    end
  end
end
