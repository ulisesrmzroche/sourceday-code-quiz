require_relative 'card'

class CardDeck
    attr_accessor :cards

    def initialize
        @cards = self.generate_cards
    end

    def shuffle!
      self.cards.shuffle!
    end

    def is_empty?
      self.cards.length == 0
    end

    def draw_cards!(x)
      unless self.is_empty?
        cards = self.cards.sample(x)
        cards.each do |card|
          self.cards.delete card
        end
        cards
      end
    end

    def total_card_count
      self.cards.length
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
