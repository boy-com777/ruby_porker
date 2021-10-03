require './message'

class Hand
  # 初回山札から引く枚数を定義
  NUMBER_OF_HAND = 5

  def initialize
    @hands []
  end

  def first_draw(deck)
    NUMBER_OF_HAND.times do
      card = deck.draw
      @hands << card
    end
  end
end
