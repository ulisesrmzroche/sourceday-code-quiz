# frozen_string_literal: true

class Player
  attr_accessor :current_hand, :current_score

  def initialize
    @current_hand = []
    @current_score = 0
  end

  def soft_hand?
    ace_card = @current_hand.find { |card| card.rank == 'A' }
    ace_card && ace_card.value == 11
  end

  def save
    update_current_score
  end

  def draw_cards_from_card_shoe(num_cards, card_shoe)
    cards = card_shoe.draw_cards(num_cards)
    card = cards&.first
    return unless card

    add_card_to_hand card
    puts "=> #{card.rank}#{card.suit}"
  end

  def can_draw?
    @current_score < 17
  end

  def did_bust?
    @current_score > 21 && !soft_hand?
  end

  def add_card_to_hand(card)
    return unless can_draw?

    @current_hand << card
    @current_hand.flatten!
  end

  def clear_current_hand
    @current_hand = []
  end

  private

  def update_current_score
    @current_score = 0
    @current_hand.each do |card|
      card.value = 11 if (card.rank == 'A') && (@current_score <= 10)
      @current_score += card.value
    end
  end
end
