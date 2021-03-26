# frozen_string_literal: true

require_relative './spinner'

# This module prints out notices and alerts
module Banners
  include Spinner

  def start_banner(options)
    intro_banner

    if options[:single_hand]
      puts 'Playing a Single Hand Game'
    else
      puts 'Playing until cards run out'
      puts 'Will shuffle shoe when only 2 card decks remaining'
    end
    puts ''
  end

  def intro_banner
    puts '======== BLACKJACK! ========='
    puts '============================='
    puts ''
  end

  def start_round_banner(round)
    puts "Round #{round}"
    puts '=============='
    spinner_indicator 10
  end

  def end_round_banner
    puts ''
  end

  def end_game_banner(opts)
    puts '======================'
    puts 'GAME END'
    puts "Total Rounds: #{opts[:round]}"
  end

  def print_scores(player, dealer)
    puts "Player Score: #{player}" if player.positive?
    puts "Dealer Score: #{dealer}" if dealer.positive?
  end

  def print_winner(winner, turn)
    puts "Winner: #{winner} on turn #{turn}" if winner && turn
  end

  def print_message(msg)
    puts msg if msg
  end

  def end_turn_banner(opts)
    print_scores opts[:player_score], opts[:dealer_score]
    print_scores opts[:winner]
    print_message opts[:msg]
    puts ''
  end

  def start_turn_banner(turn)
    puts "Turn #{turn}"
    puts '------------'
    spinner_indicator 10
  end
end
