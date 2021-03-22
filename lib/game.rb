require 'card_shoe'
require 'dealer'
require 'player'

class Game 
    def initialize(player, dealer, options)
        @card_shoe = CardShoe.new
        @player = player || Player.new
        @dealer = dealer || Dealer.new
        @status = ""
        @round = 1
        @winner = nil
        @single_hand_game = options['single_hand']
    end

    def start
        resolve_round @round
        unless @single_hand_game
            resolve_round @round += 1
        end
    end

    def resolve_round(round)
        setup_player_and_dealer
        resolve_first_turn
        unless @winner then
            resolve_turn @turn += 1
        end
    end

    def draw_card(u)
        card = @card_shoe.draw_card!
        u.current_hand << card
        u.update_current_score!
    end

    def resolve_turn(round)

        if @player.can_draw? && @dealer.can_draw?
            draw_card(@player)
            draw_card(@dealer)
        end

        if @player.can_draw? && !@dealer.can_draw?
            draw_card(@player)
        end

        check_scores

        if @winner
            @end_msg = "#{@winner} is victorious!"
            end_game
        end

    end

    def check_scores
        pcs = @player.current_score
        dcs = @dealer.current_score

        if @dealer.busts?
            @winner = "Player" if pcs <= 21
        end

        if @player.busts?
            @winner = "Dealer"
        end

        @winner = "Player" if !@player.busts? and pcs > dcs
        @winner = "Dealer" if !@dealer.busts? and dcs > pcs
        @winner = "Push" if pcs == dcs
        
    end

    def resolve_first_turn
        pcs = @player.current_score
        dcs = @dealer.current_score

        is_player_win = pcs == 21 && dcs != 21
        is_tie = pcs == 21 && dcs == 21

        if is_player_win
            @winner = "Player"
            @end_msg = "Congrats! Natural Blackjack"
            @status = "win"
            end_round
            return
        end

        if is_tie
            @winner = "None"
            @status = "draw"
            @end_msg = "It's a tie!"
            end_round
            return
        end

        @round += 1
    end

    def end_round
        puts @end_msg
        puts "Winner is #{@winner}"
        exit
    end

    def setup_player_and_dealer
        [@player, @dealer].each do |x|
            cards = @card_shoe.draw!(2)
            x.current_hand = cards
            x.update_current_score!
        end
    end

end
