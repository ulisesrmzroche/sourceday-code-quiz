# frozen_string_literal: true
# TODO: This should be refactored with a State Machine
module ScoreChecker
  def get_winner(player, dealer, turn)
    pcs = player.current_score
    dcs = dealer.current_score

    return get_first_turn_winner(player, dealer) if turn == 1

    winner = 'Player' if dealer.did_bust? && (pcs <= 21)

    winner = 'Dealer' if player.did_bust? && !dealer.did_bust?

    winner = 'None' if dealer.did_bust? && player.did_bust?

    winner = 'Player' if !player.did_bust? && pcs > dcs && !dealer.can_draw?
    winner = 'Dealer' if !dealer.did_bust? && dcs > pcs && !player.can_draw?
    winner = 'Push' if pcs == dcs && (!player.did_bust? && !dealer.did_bust?)

    winner
  end

  def get_first_turn_winner(pcs, dcs)
    is_player_win = pcs == 21 && dcs != 21
    is_tie = pcs == 21 && dcs == 21
    'Player' if is_player_win
    'None' if is_tie
  end
end
