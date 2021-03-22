require_relative 'player'

class Dealer < Player
    def did_bust?
        @current_score > 21
    end
end
