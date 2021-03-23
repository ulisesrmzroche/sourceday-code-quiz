module ScoreChecker

    def get_winner(player, dealer, turn)
        pcs = player.current_score
        dcs = dealer.current_score

        if turn == 1
            is_player_win = pcs == 21 && dcs != 21
            is_tie = pcs == 21 && dcs == 21
            if is_player_win
                winner = "Player"
            end
            if is_tie
                winner = "None"
            end
        else
            if dealer.did_bust?
                winner = "Player" if pcs <= 21
            end

            if player.did_bust?
                winner = "Dealer" unless dealer.did_bust?
            end

            if dealer.did_bust? && player.did_bust?
                winner = "None"
            end

            winner = "Player" if !player.did_bust? && pcs > dcs && !dealer.can_draw?
            winner = "Dealer" if !dealer.did_bust? && dcs > pcs && !player.can_draw?
            winner = "Push" if pcs == dcs && (!player.did_bust? && !dealer.did_bust?)

            return winner
        end
    end
end