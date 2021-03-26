# frozen_string_literal: true

require_relative 'card'

require_relative 'card_deck_builder'
class CardDeck
  attr_accessor :cards

  def initialize
    @cards = CardDeckBuilder.build
  end

  def shuffle
    @cards.shuffle!
  end

  def empty?
    @cards.length.zero?
  end

  def total_card_count
    cards.length
  end
end
