# frozen_string_literal: true

require 'blackjack'

RSpec.describe Blackjack do
  it 'should have a Player' do
    bj = Blackjack.new
    expect(bj.instance_variable_get(:@dealer)).to_not be_nil
    expect(bj.instance_variable_get(:@dealer)).to be_a Player
  end

  it 'should have a Dealer' do
    bj = Blackjack.new
    expect(bj.instance_variable_get(:@dealer)).to_not be_nil
    expect(bj.instance_variable_get(:@dealer)).to be_a Dealer
  end
end
