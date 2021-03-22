class User

    attr_accesor :current_hand, :current_score

    def initialize
        @current_hand = []
        @current_score = 0
    end
   
    def update_current_score!
        @current_score = 0
        @current_hand.each do |c|
          @current_score += c.value
        end
    end
end
