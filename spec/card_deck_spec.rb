# frozen_string_literal: true

require 'card_deck'

RSpec.describe CardDeck do
  describe '#shuffle' do
    it 'should have a shuffle' do
      cd = CardDeck.new
      expect(cd).to respond_to :shuffle!
    end
  end

  it 'should start with 52 cards' do
    cd = CardDeck.new
    cards = cd.instance_variable_get(:@cards)
    expect(cards.length).to eq(52)
  end
end
