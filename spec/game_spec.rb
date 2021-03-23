require 'game'
require 'dealer'
require 'player'

RSpec.describe Game do 

    before :each do
        @dealer = Dealer.new
        @player = Player.new
        @game = Game.new(@player, @dealer, { single_hand: true })
    end

    it "should start without a winner" do
        expect(@game.winner).to be_nil
    end

    it "should end at round 1 given single hand game" do
        g = Game.new(@player, @dealer, { single_hand: true })
        g.start
        expect(@game.round).to eq 1
    end

end
