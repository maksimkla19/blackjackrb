require_relative 'interface'
require_relative 'hand'

class Player
  include Interface

  attr_reader :name, :bank, :hand

  def initialize(name, bank)
    @name = name
    @bank = bank
    @hand = Hand.new
  end

  def decision
    Interface.menu(Interface::CHOICES_MENU)
  end

  def place_bet(bet)
    @bank -= bet
  end

  def topup_bank(num)
    @bank += num
  end
end
