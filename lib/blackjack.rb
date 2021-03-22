require 'dealer'
require 'player'
require 'game'

class Blackjack 
    def initialize(single_hand=false)
        @dealer = Dealer.new
        @player = Player.new
        @game = Game.new(@player, @dealer, { single_hand: single_hand })
    end

    def start
        @game.start
    end

end
