require 'card_shoe'

RSpec.describe CardShoe do 
    it "should start with six card decks" do
        cs = CardShoe.new
        card_decks = cs.instance_variable_get(:@card_decks)
        expect(card_decks.length).to eq(6)
    end

    it "should draw a given number of cards fron a random deck" do
        cs = CardShoe.new
        expect(cs.total_card_count).to eq(312) 
        cs.draw!(2)
        expect(cs.total_card_count).to eq(310) 
    end

end
