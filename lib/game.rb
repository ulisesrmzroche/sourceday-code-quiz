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

  def start
    start_banner @options
    resolve_round @round until @game_over
    end_game
  end

  def resolve_round(round)
    if @card_shoe.empty?
      @game_over = true
      @end_msg = 'Ran out of cards. Game over'
      return
    end

    setup_player_and_dealer

    return if @player.current_score.zero? || @dealer.current_score.zero?

    start_round_banner round
    resolve_turn @turn until @winner
    end_round

    if @single_hand_game
      @game_over = true
      @round = 1
    end
  end


  def resolve_turn(turn)
    return if @winner

    if @card_shoe.empty?
      @game_over = true
      @end_msg = 'Ran out of cards. Game over'
      return
    end

    start_turn_banner turn

    if turn == 1
      check_scores turn
    else
      if @player.can_draw?
        puts 'Player hits...'
        @player.draw_card_from_card_shoe @card_shoe
        @player.save
      else
        puts 'Player holds...'
      end

      if @dealer.can_draw?
        puts 'Dealer hits...'
        @dealer.draw_card_from_card_shoe @card_shoe
        @dealer.save
      else
        puts 'Dealer holds...'
      end
      check_scores turn
    end
    end_turn
  end

  def check_scores(turn)
    @winner = get_winner(@player, @dealer, turn)
  end

  def end_round
    @round += 1
    @turn = 1
    @player.clear_current_hand
    @dealer.clear_current_hand
    @player.save
    @dealer.save
    @winner = nil
    @end_msg = nil
    end_round_banner
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

  def setup_player_and_dealer
    [@player, @dealer].each do |user|
      user.draw_card_from_card_shoe @card_shoe
      user.save
    end
  end

  def end_game
    end_game_banner({
                      round: @round
                    })
  end
end
