require_relative 'card'

class CardDeck
    def initialize
        @cards = self.generate_cards
    end

    def shuffle!
      @cards.shuffle!
    end

    def draw_cards!(x)
      cards = @cards.sample(2)
      cards.each do |card|
        @cards.delete card
      end
      cards
    end

    def total_card_count
      @cards.length
    end

    def generate_cards
        stack = []
        ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
        suits = %w{s h d c}
        suits.each do |suit|
          ranks.size.times do |i|
            stack << Card.new( ranks[i], suit)
          end
        end
        return stack
    end
end
