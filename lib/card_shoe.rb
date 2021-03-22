require_relative 'card_deck'

class CardShoe 
    attr_accessor :card_decks, :num_decks

    def initialize(num_decks = 6)
        @num_decks = num_decks
        @card_decks = self.generate_card_decks(@num_decks) || []
    end

    def generate_card_decks(x)
        card_decks = []
        x.times do
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

    def can_draw?
        total_card_count > 0
    end

    def is_empty?
        total_card_count == 0
    end

    def has_two_decks_remaining?
      @card_decks.length === 2
    end

    def shuffle_decks
      @card_decks.each do |deck|
        @deck.shuffle!
      end
    end

    def draw_card!(x)

        if has_two_decks_remaining?
            shuffle_decks
        end

        # from a random deck pick two cards
        target_card_deck = @card_decks.sample
        cards = target_card_deck.draw_cards!(x)
        cards
    end

end
