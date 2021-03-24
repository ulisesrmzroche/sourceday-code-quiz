class Player

    attr_accessor :current_hand, :current_score

    def initialize
        @current_hand = []
        @current_score = 0
    end
   
    def has_soft_hand?
       hand = @current_hand.select { |c| c.rank == "A" }
       card = hand.first unless hand.empty?
       return true if card && card.value == 11
       return false
    end

    def save
        self.update_current_score!
    end

    def can_draw?
        @current_score < 17
    end

    def did_bust?
        @current_score > 21 && !self.has_soft_hand?
    end

    def add_card_to_hand(card)
        if self.can_draw?
            @current_hand << card
            @current_hand.flatten!
        end
    end

    def clear_current_hand
        @current_hand = []
    end

    private

    def update_current_score!
        @current_score = 0
        @current_hand.each do |c|
          if c.rank === "A" and @current_score <= 10
            c.value = 11
          end
          @current_score += c.value
        end
    end

end
