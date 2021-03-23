module Banners
    def start_banner options
        puts ""
        puts "======== BLACKJACK! ========="
        puts "============================="
        puts ""

        if options[:single_hand]
            puts "Playing a Single Hand Game"
        else
            puts "Playing until cards run out"
            puts "Will shuffle shoe when only 2 card decks remaining"
        end
        puts ""
        puts ""
    end

    def start_round_banner(round)
        puts "Round #{round}"
        puts "=============="
        self.spinner_indicator 10
    end

    def end_round_banner
        puts ""
    end

    def end_game_banner opts
        puts "======================"
        puts "GAME END"
        puts "Total Rounds: #{opts[:round]}"
    end

    def end_turn_banner opts
        puts ""
        puts "Player Score: #{opts[:player_score]}" if opts[:player_score] > 0
        puts "Dealer Score: #{opts[:dealer_score]}" if opts[:dealer_score] > 0
        puts "Winner: #{opts[:winner]} on turn #{opts[:turn]}" if opts[:winner] and opts[:turn]
        puts opts[:msg] if opts[:msg]
        puts ""
    end

    def start_turn_banner turn
        puts "Turn #{turn}"
        puts "------------"
        self.spinner_indicator 10
    end
    def spinner_indicator time
        # Prints a text-based "spinner" element while work occurs.
        spinner = Enumerator.new do |e|
            loop do
            e.yield '|'
            e.yield '/'
            e.yield '-'
            e.yield '\\'
            end
        end
        1.upto(time) do |i|
            printf("\r %s", spinner.next)
            sleep(0.1)
        end
    end
    
end