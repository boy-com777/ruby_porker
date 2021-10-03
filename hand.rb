require './message'

class Hand
  include Message

  attr_accessor :show_hands

  # 手札5枚引くのを定数で定義
  NUMBER_OF_HAND = 5

  def initialize
    @hands = []
  end

  # 手札を山札から引く
  def first_draw_player(deck)
    NUMBER_OF_HAND.times do
      card = deck.draw
      @hands << card
    end

    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def hands_list_player
    puts '=*=*=*=*= プレイヤー 手札 =*=*=*=*=*='
    @hands.each.with_index(1) do |hand, i|
      puts "#{i}. #{hand[0]}の#{hand[1]}"
    end
  end

  def second_draw_player(deck)
    information2
    @change_number = gets.chomp.split(&:to_s)
    @change = Regexp.new(/^\d$|\d\s/)
    if @change =~ @change_number
      @hands[0] = deck.draw if @change_number.include?('1')
      @hands[1] = deck.draw if @change_number.include?('2')
      @hands[2] = deck.draw if @change_number.include?('3')
      @hands[3] = deck.draw if @change_number.include?('4')
      @hands[4] = deck.draw if @change_number.include?('5')
      @show_hands = []
      @show_hands << @hands
    else
      information3
    end
  end
end
