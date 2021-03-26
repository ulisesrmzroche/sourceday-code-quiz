# frozen_string_literal: true

module CardDeckBuilder
  def self.build
    stack = []
    ranks = %w[A 2 3 4 5 6 7 8 9 10 J Q K]
    suits = %w[s h d c]
    suits.each do |suit|
      ranks.size.times do |rank|
        stack << Card.new(ranks[rank], suit)
      end
    end
    stack
  end
end
