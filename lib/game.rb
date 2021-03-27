# frozen_string_literal: true

require_relative 'card_shoe'
require_relative 'dealer'
require_relative 'player'
require_relative 'banners'
require_relative 'score_checker'

class Game
  include Banners
  include ScoreChecker

  attr_accessor :card_shoe, :winner, :round

  def initialize(options)
    @card_shoe = CardShoe.new
    @player = Player.new
    @dealer = Dealer.new
    @round = 1
    @turn = 1
    @winner = nil
    @end_msg = ''
    @single_hand_game = options[:single_hand] || false
    @game_over = false
    @options = options
  end

  def players
    [@player, @dealer]
  end

  def start
    start_banner @options
    resolve_round @round until @game_over
    exit_game
  end

  def end_game(options = {})
    @game_over = true
    puts options[:msg]
    puts ''
  end

  def resolve_round(round)
    return end_game msg: 'Ran out of cards. Game over' if @card_shoe.empty?

    start_round_banner round
    resolve_turn @turn until @winner
    end_round

    return end_game msg: 'Single Hand Game' if single_hand_game?
  end

  def single_hand_game?
    @single_hand_game == true
  end

  def draw_cards_for_user(num_cards, user)
    if user.can_draw?
      puts "#{user.name} hits..."
      user.draw_cards_from_card_shoe num_cards, @card_shoe
      user.save
    else
      puts "#{user.name} holds..."
    end
  end

  def resolve_turn(turn)
    return end_game msg: 'Ran out of cards. Game over' if @card_shoe.empty?

    start_turn_banner turn

    num_cards = first_turn? ? 1 : 2
    players.each do |player|
      draw_cards_for_user num_cards, player
    end
    return if zero_scores? && first_turn?

    @winner = get_winner(@player, @dealer, @turn)
    end_turn
  end

  def first_turn?
    @turn == 1
  end

  def zero_scores?
    @player.current_score.zero? || @dealer.current_score.zero?
  end

  def clear_game_state
    @winner = nil
    @end_msg = nil
  end

  def end_round
    reset_timers
    clear_cards
    clear_game_state
    end_round_banner
  end

  def reset_timers
    @round += 1
    @turn = 1
  end

  def clear_cards
    players.each do |player|
      player.clear_current_hand
      player.save
    end
  end

  def end_turn
    end_turn_banner({
                      player_score: @player.current_score,
                      dealer_score: @dealer.current_score,
                      winner: @winner,
                      turn: @turn,
                      msg: @end_msg
                    })
    @turn += 1
    @end_msg = ''
  end

  def exit_game
    end_game_banner({
                      round: @round
                    })
  end
end
