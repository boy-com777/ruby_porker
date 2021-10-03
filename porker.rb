require './deck'
require './hand'
require './message'

class Porker
  include Message

  def start
    start_message
    build_deck
    build_hand
    @hand.first_draw(@deck)
    @hand.hands_list
  end

  private

  def build_deck
    @deck = Deck.new
  end

  def build_hand
    @hand = Hand.new
  end
end
