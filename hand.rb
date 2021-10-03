require './message'

class Hand
  attr_accessor :show_hands

  # 初回山札から引く枚数を定義
  NUMBER_OF_HAND = 5

  def initialize
    @hands = []
  end

  def first_draw(deck)
    NUMBER_OF_HAND.times do
      card = deck.draw
      @hands << card
    end

    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def hands_list
    @hands.each.with_index(1) do |hand, i|
      mark = hand[0]
      number = hand[1]
      puts "#{i}. #{mark}の#{number}"
    end
  end
end
