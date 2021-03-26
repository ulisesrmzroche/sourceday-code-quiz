# frozen_string_literal: true

require 'card'

RSpec.describe Card do
  it 'should have a card value' do
    card = Card.new('2', 's')
    expect(card.value).to eq(2)
  end

  it 'should have a card value of 10 given J, Q, K' do
    card = Card.new('J', 's')
    expect(card.value).to eq(10)
    card = Card.new('Q', 's')
    expect(card.value).to eq(10)
    card = Card.new('K', 's')
    expect(card.value).to eq(10)
  end
end
