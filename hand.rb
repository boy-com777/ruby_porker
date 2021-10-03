require './message'

class Hand
  attr_accessor :show_hands

  include Message

  def initialize
    @hands = []
  end

  # 初回山札から引く枚数を定義
  NUMBER_OF_HAND = 5

  def first_draw(deck)
    NUMBER_OF_HAND.times do
      card = deck.draw
      @hands << card
    end

    @hands_type = []
    @hands.each do |hand|
      @hands_type << hand
    end
    @hands_type.flatten!
  end

  def hands_list
    @hands.each.with_index(1) do |hand, i|
      mark = hand[0]
      number = hand[1]
      puts "#{i}. #{mark}の#{number}"
    end
  end
end
