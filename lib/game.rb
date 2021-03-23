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

        end_round

        if @single_hand_game
            exit
        else
            resolve_round @round
        end
    end

    def draw_card(u)
        cards = @card_shoe.draw_cards!(1)
        card = cards && cards.first
        if card
            u.add_card_to_hand card
            u.save
        end
    end

    def resolve_turn(turn)
        puts "Turn #{turn}"


        if @card_shoe.is_empty?
            puts "Ran out of cards. Game is over"
            exit
        end

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

        end_turn

    end

    def check_scores
        pcs = @player.current_score
        dcs = @dealer.current_score

        if @dealer.did_bust?
            @winner = "Player" if pcs <= 21
            @end_msg = "Dealer bust!"
        end

        if @player.did_bust?
            @winner = "Dealer" unless @dealer.did_bust?
            @end_msg = "Player bust!"
        end

        if @dealer.did_bust? and @player.did_bust?
            @winner = "None"
            @end_msg = "Both players busted"
        end

        @winner = "Player" if !@player.did_bust? and pcs > dcs
        @winner = "Dealer" if !@dealer.did_bust? and dcs > pcs
        @winner = "Push" if pcs == dcs and (!@player.did_bust? && !@dealer.did_bust?)
        
    end

    def end_round
        @round += 1
        @turn = 1
        @player.clear_current_hand
        @dealer.clear_current_hand
        @player.save
        @dealer.save
        puts ""
        puts ""
    end

    def resolve_first_turn

        puts "Turn 1"
        pcs = @player.current_score
        dcs = @dealer.current_score

        if pcs == 0 || dcs == 0
            end_turn
            return
        end

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
        puts "Player Score: #{@player.current_score}" if @player.current_score > 0
        puts "Dealer Score: #{@dealer.current_score}" if @dealer.current_score > 0
        puts "Winner: #{@winner}" if @winner
        puts @end_msg
        puts ""
        @winner = nil
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

end
