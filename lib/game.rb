require_relative 'card_shoe'
require_relative 'dealer'
require_relative 'player'
require_relative 'banners'

class Game 
    include Banners

    attr_accessor :card_shoe, :winner, :round

    def initialize(player, dealer, options)
        @card_shoe = CardShoe.new
        @player = player || Player.new
        @dealer = dealer || Dealer.new
        @round = 1
        @turn = 1
        @winner = nil
        @end_msg = ""
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
        if @card_shoe.is_empty?
            @game_over = true
            @end_msg = "Ran out of cards. Game over"
            return
        end

        setup_player_and_dealer

        return if @player.current_score == 0 || @dealer.current_score == 0

        start_round_banner round
        resolve_turn @turn until @winner
        end_round

        if @single_hand_game
            @game_over = true
            @round = 1
        end
    end

    def draw_card(u)
        cards = @card_shoe.draw_cards!(1)
        card = cards && cards.first
        if card
            u.add_card_to_hand card
            u.save
            puts "=> #{card.rank}#{card.suit}"
        end
    end

    def resolve_turn(turn)
        return if @winner

        if @card_shoe.is_empty?
            @game_over = true
            @end_msg = "Ran out of cards. Game over"
            return
        end

        start_turn_banner turn

        if turn == 1
            check_scores
        else
            if @player.can_draw?
                puts "Player hits..."
                draw_card(@player)
            else
                puts "Player holds..."
            end

            if @dealer.can_draw?
                puts "Dealer hits..."
                draw_card(@dealer)
            else
                puts "Dealer holds..."
            end
            check_scores
        end
        end_turn
    end

    def check_scores
        pcs = @player.current_score
        dcs = @dealer.current_score
        if @turn == 1
            is_player_win = pcs == 21 && dcs != 21
            is_tie = pcs == 21 && dcs == 21
            if is_player_win
                @winner = "Player"
                @end_msg = "Congrats! Natural Blackjack"
            end
            if is_tie
                @winner = "None"
                @end_msg = "It's a tie!"
            end
        else
            if @dealer.did_bust?
                @winner = "Player" if pcs <= 21
                @end_msg = "Dealer bust!"
            end

            if @player.did_bust?
                @winner = "Dealer" unless @dealer.did_bust?
                @end_msg = "Player bust!"
            end

            if @dealer.did_bust? && @player.did_bust?
                @winner = "None"
                @end_msg = "Both players busted"
            end

            @winner = "Player" if !@player.did_bust? && pcs > dcs && !@dealer.can_draw?
            @winner = "Dealer" if !@dealer.did_bust? && dcs > pcs && !@player.can_draw?
            @winner = "Push" if pcs == dcs && (!@player.did_bust? && !@dealer.did_bust?)
        end
        
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
        @end_msg = ""
    end

    def setup_player_and_dealer
        [@player, @dealer].each do |x|
            cards = @card_shoe.draw_cards!(2)
            if cards && cards.length == 2
                cards.each do |c|
                    x.add_card_to_hand c
                end
                x.save
            end
        end
    end

    def end_game
        end_game_banner({
            round: @round
        })
    end
end
