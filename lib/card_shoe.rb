# frozen_string_literal: true

require_relative 'card_deck'

class CardShoe
  attr_accessor :card_decks, :num_decks, :did_shuffle

  def initialize(num_decks = 6)
    @num_decks = num_decks
    @card_decks = generate_card_decks(@num_decks) || []
    @did_shuffle = false
  end

  def did_shuffle?
    did_shuffle == true
  end

  def generate_card_decks(x)
    card_decks = []
    x.times do
      deck = CardDeck.new
      deck.shuffle!
      card_decks << deck
    end
    card_decks
  end

  def total_card_count
    total = 0
    @card_decks.each do |deck|
      total += deck.total_card_count
    end
    total
  end

  def can_draw?
    total_card_count.positive?
  end

  def is_empty?
    total_card_count.zero?
  end

  def has_two_decks_remaining?
    @card_decks.length == 2
  end

  def shuffle_decks
    @card_decks.each(&:shuffle!)
    @did_shuffle = true
  end

  def draw_cards!(x)
    cards = []
    return [] if is_empty?

    if has_two_decks_remaining? && !did_shuffle?
      shuffle_decks
      return []
    end

    target_card_deck = @card_decks.sample
    if target_card_deck.is_empty?
      @card_decks.delete target_card_deck
      target_card_deck = @card_decks.sample
    end
    target_card_deck.draw_cards!(x)
  end
end
