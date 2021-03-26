# frozen_string_literal: true

require 'blackjack'

RSpec.describe Blackjack do
  it 'should have a Game' do
    bj = Blackjack.new
    expect(bj.instance_variable_get(:@game)).to_not be_nil
    expect(bj.instance_variable_get(:@game)).to be_a Game
  end
end
