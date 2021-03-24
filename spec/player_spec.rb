require 'card'

RSpec.describe Player do 

    before :each do
        @player = Player.new
        @deck = CardDeck.new
    end

    it "should not add cards to hand if total is 17 or higher" do
        deck = CardDeck.new
        p = Player.new
        p.current_score = 17
        card = deck.draw_cards!(1)
        p.add_card_to_hand(card)
        expect(p.current_score).to eq(17)
    end

    it "should count A as 1 if bust" do
        deck = CardDeck.new
        p = Player.new
        card1 = Card.new('7', 's')
        card2 = Card.new('2', 'q')
        card3 = Card.new('A', 's')
        p.add_card_to_hand(card1)
        p.add_card_to_hand(card2)
        p.save
        expect(p.current_score).to eq(9)
        p.add_card_to_hand(card3)
        p.save
        expect(p.current_score).to eq(20)
    end

    it "should count A as 11 if no bust" do
        deck = CardDeck.new
        p = Player.new
        card1 = Card.new('2', 's')
        card2 = Card.new('2', 's')
        card3 = Card.new('A', 's')
        p.add_card_to_hand(card1)
        p.add_card_to_hand(card2)
        p.save
        p.add_card_to_hand(card3)
        p.save
        expect(p.current_score).to eq(15)
    end

    it "current hand should be considered 'soft' if holding an ace valued as 11" do
        @player.current_hand = [
          Card.new("A", 's'),
          Card.new("2", 's'),
        ]
        @player.save
        @player.add_card_to_hand Card.new("10", "d")
        @player.save
        expect(@player.has_soft_hand?).to be true
    end

    it "current hand is 'soft' then player should not bust" do
        @player.current_hand = [
          Card.new("3", 's'),
          Card.new("A", 's'),
        ]
        @player.save
        @player.add_card_to_hand Card.new("10", "d")
        @player.save
        expect(@player.did_bust?).to be false
    end

    pending "current hand is 'soft' then max score is 21"

    it "current hand should be considered 'hard' unlesss holding an ace valued as 11" do
        @player.current_hand = [
          Card.new("8", 'd'),
          Card.new("8", 's'),
        ]
        @player.save
        @player.add_card_to_hand Card.new("A", "d")
        @player.save
        expect(@player.has_soft_hand?).to be false
    end

end
