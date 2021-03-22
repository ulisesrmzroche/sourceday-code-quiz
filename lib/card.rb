class Card
    attr_accessor :rank, :suit, :value

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
        @value = determine_value
    end

    def determine_value

        case @rank
            when "A"
                1
            when "K", "Q", "J"
                10
            else
                @rank.to_i
        end
    end

end