# frozen_string_literal: true

require_relative 'game'

# Blackjack accepts an array of options
# and returns a new game based on the options given.
# ruby ./bin/run single_hand would setup a single hand game
class Blackjack
  def initialize(options = [])
    @game = Game.new({
                       single_hand: options.include?('single_hand') ? true : false
                     })
  end

  def start
    @game.start
  end
end
