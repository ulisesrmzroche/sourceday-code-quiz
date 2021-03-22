class CardShoe 
    def initialize
        @card_decks = self.generate_card_decks || []
    end

    def generate_card_decks
        card_decks = []
        6.times do
            deck = CardDeck.new
            deck.shuffle!
            card_decks << deck
        end
        return card_decks
    end

    def total_card_count
        total = 0
        @card_decks.each do |deck|
            total += deck.total_card_count
        end
        total
    end

    def draw!(x)
        # if only two decks remain, shuffle
        if @card_decks.length === 2
            @card_decks.each do |deck|
                @deck.shuffle!
            end
        end

        # from a random deck pick two cards
        target_card_deck = @card_decks.sample
        cards = target_card_deck.draw_cards!(x)
        cards
    end

end
