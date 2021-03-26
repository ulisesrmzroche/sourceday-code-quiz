# frozen_string_literal: true

require 'card_shoe'

RSpec.describe CardShoe do
  it 'should start with six card decks' do
    cs = CardShoe.new
    card_decks = cs.instance_variable_get(:@card_decks)
    expect(card_decks.length).to eq(6)
  end

  it 'should draw a given number of cards fron a random deck' do
    cs = CardShoe.new
    expect(cs.total_card_count).to eq(312)
    cs.draw_cards!(2)
    expect(cs.total_card_count).to eq(310)
  end

  it 'should shuffle decks given 2 decks remain' do
    cs = CardShoe.new
    expect(cs.instance_variable_get(:@did_shuffle)).to be false
    cs.card_decks = [
      cs.card_decks[0],
      cs.card_decks[1]
    ]
    cs.draw_cards!(2)
    expect(cs.instance_variable_get(:@did_shuffle)).to be true
  end
end
