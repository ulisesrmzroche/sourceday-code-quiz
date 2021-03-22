require_relative 'card_shoe'
require_relative 'dealer'
require_relative 'player'

class Game 
    def initialize(player, dealer, options)
        @card_shoe = CardShoe.new
        @player = player || Player.new
        @dealer = dealer || Dealer.new
        @round = 1
        @turn = 1
        @winner = nil
        @end_msg = ""
        @single_hand_game = options[:single_hand] || false
    end

    def start
        resolve_round @round
        unless @single_hand_game
            resolve_round @round
        end
    end

    def resolve_round(round)
        puts "Round #{round}"
        puts "=============="
        setup_player_and_dealer
        resolve_first_turn
        unless @winner then
            resolve_turn @turn
        end
        @round += 1
        @turn = 1
        puts ""
        puts ""
        if @single_hand_game
            exit
        else
            resolve_round @round
        end
    end

    def draw_card(u)
        card = @card_shoe.draw_card!(1)
        u.current_hand << card
        u.current_hand.flatten!
        u.save
    end

    def resolve_turn(turn)
        puts "Turn #{turn}"

        if @card_shoe.is_empty?
            puts "Ran out of cards. Game is over"
            exit
        end

        if @player.can_draw?
            draw_card(@player)
        end

        if @dealer.can_draw?
            draw_card(@dealer)
        end

        check_scores

        end_turn

    end

    def check_scores
        pcs = @player.current_score
        dcs = @dealer.current_score

        if @dealer.did_bust?
            @winner = "Player" if pcs <= 21
        end

        if @player.did_bust?
            @winner = "Dealer" unless @dealer.did_bust?
        end

        if @dealer.did_bust? and @player.did_bust?
            @winner = "None"
            @end_msg = "Both players busted"
        end

        @winner = "Player" if !@player.did_bust? and pcs > dcs
        @winner = "Dealer" if !@dealer.did_bust? and dcs > pcs
        @winner = "Push" if pcs == dcs
        
    end

    def resolve_first_turn
        puts "Turn 1"
        pcs = @player.current_score
        dcs = @dealer.current_score

        is_player_win = pcs == 21 && dcs != 21
        is_tie = pcs == 21 && dcs == 21

        if is_player_win
            @winner = "Player"
            @end_msg = "Congrats! Natural Blackjack"
            end_turn
            return
        end

        if is_tie
            @winner = "None"
            @end_msg = "It's a tie!"
            end_turn
            return
        end

        end_turn
    
    end

    def end_turn
        puts "Player Score: #{@player.current_score}"
        puts "Dealer Score: #{@dealer.current_score}"
        puts "Winner: #{@winner}" if @winner
        puts @end_msg
        puts ""
        @winner = nil
        @turn += 1
    end

    def setup_player_and_dealer
        [@player, @dealer].each do |x|
            cards = @card_shoe.draw_card!(2)
            x.current_hand = cards
            x.save
        end
    end

end
