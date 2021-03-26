# frozen_string_literal: true

class Player
  attr_accessor :current_hand, :current_score

  def initialize
    @current_hand = []
    @current_score = 0
  end

  def has_soft_hand?
    hand = @current_hand.select { |c| c.rank == 'A' }
    card = hand.first unless hand.empty?
    return true if card && card.value == 11

    false
  end

  def save
    update_current_score!
  end

  def draw_card_from_card_shoe(card_shoe)
    cards = card_shoe.draw_cards(1)
    card = cards&.first
    return unless card

    add_card_to_hand card
    puts "=> #{card.rank}#{card.suit}"
  end

  def can_draw?
    @current_score < 17
  end

  def did_bust?
    @current_score > 21 && !has_soft_hand?
  end

  def add_card_to_hand(card)
    if can_draw?
      @current_hand << card
      @current_hand.flatten!
    end
  end

  def clear_current_hand
    @current_hand = []
  end

  private

  def update_current_score!
    @current_score = 0
    @current_hand.each do |c|
      c.value = 11 if (c.rank == 'A') && (@current_score <= 10)
      @current_score += c.value
    end
  end
end
