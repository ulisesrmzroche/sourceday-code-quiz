# frozen_string_literal: true

require_relative 'blackjack'

is_single_hand = true if ARGV[0] == 'single_hand'

game = Blackjack.new(single_hand: is_single_hand)
game.start
