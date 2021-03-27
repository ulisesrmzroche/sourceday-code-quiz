# frozen_string_literal: true

# TODO: This should be refactored into a class
module ScoreChecker
  def get_winner(player, dealer, turn)
    return 'Player' if player_won?(player, dealer, turn)
    return 'Dealer' if dealer_won?(player, dealer, turn)
    return 'None' if both_busted?(player, dealer) || tied?(player, dealer)
    return 'Push' if player.current_score == dealer.current_score && !both_busted?
  end

  def player_won?(player, dealer, turn)
    dealer.did_bust? && (player.current_score <= 21) ||
      !player.did_bust? && player.current_score > dealer.current_score && !dealer.can_draw? ||
      player.current_score == 21 && dealer.current_score != 21 && turn == 1
  end

  def dealer_won?(player, dealer, turn)
    player.did_bust? && !dealer.did_bust? ||
      !dealer.current_score > player.current_score && !player.can_draw?
  end

  def both_busted?(player, dealer)
    dealer.did_bust? && player.did_bust?
  end

  def tied?(player, dealer)
    player.current_score == 21 && dealer.current_score == 21
  end

end
