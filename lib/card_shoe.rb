# frozen_string_literal: true

require_relative 'card_deck'

# CardShoe is where the player draw cards from
# A card shoe consists of all the cards from a given number of decks
class CardShoe
  attr_accessor :card_decks, :num_decks, :did_shuffle

  def initialize(num_decks = 6)
    @card_decks = generate_card_decks(num_decks) || []
    @cards = @card_decks.flatten
    @did_shuffle = false
  end

  def shuffled?
    @did_shuffle == true
  end

  def generate_card_decks(num_decks)
    card_decks = []
    num_decks.times do
      deck = CardDeck.new
      deck.shuffle
      card_decks << deck.cards
    end
    card_decks
  end

  def total_card_count
    @cards.length
  end

  def can_draw?
    total_card_count.positive?
  end

  def empty?
    total_card_count.zero?
  end

  def two_decks_remaining?
    @card_decks.length == 2
  end

  def shuffle_cards
    @cards.shuffle!
    @did_shuffle = true
  end

  def draw_cards(num_cards)
    return [] if empty?
    return shuffle_cards if two_decks_remaining? && !shuffled?

    cards = @cards.sample num_cards
    cards.each do |card|
      @cards.delete card
    end
    cards
  end
end
