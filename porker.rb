require './deck'
require './hand'
require './message'

class Porker
  include Message

  def initialize
    build_deck
    build_hand
  end

  def start
    start_message
    build_deck
    build_hand
    @hand.first_draw(@deck)
    display_hands
    @hand.hands_list
    @hand_type = hand_type
  end

  private

  def build_deck
    @deck = Deck.new
  end

  def build_hand
    @hand = Hand.new
  end

  # 役確認の為のマー���カウントを定数化
  FIVE_SAME_MARK = 5

  # 手札の数字の差分が1になることを定義
  DIFFERENCE = 1

  def hand_type
    # マークの数を集計
    @sum_hands = @hand.hands_type.flatten!
    @spade = @sum_hands.count('スペイド')
    @heart = @sum_hands.count('ハート')
    @diamond = @sum_hands.count('ダイア')
    @clober = @sum_hands.count('クラブ')

    # マークを削除して数字のみにし、昇順で並び替え
    @sum_hands.delete('スペイド')
    @sum_hands.delete('ハート')
    @sum_hands.delete('ダイア')
    @sum_hands.delete('クラブ')
    @sum_hands.sort!

    @array = @sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
    if @spade == FIVE_SAME_MARK || @heart == FIVE_SAME_MARK || @diamond == FIVE_SAME_MARK || @clober == FIVE_SAME_MARK
      if @hand.hands_type[0] == @deck.numbers(0) && @hands_type[1] == @deck.numbers[9] && @hands_type[2] == @deck.numbers[10] && @hands_type[3] == @deck.numbers[11] && @hands_type[4] == @deck.numbers[12]
        puts 'Royal Straight Flush'
      elsif (@hand.hands_type[0] - @hand.hands_type).abs == DIFFERENCE && (@hand.hands_type[1] - @hand.hands_type[2]).abs == DIFFERENCE && (@hand.hands_type[2] - @hand.hands_type[3]).abs == DIFFERENCE && (@hand.hands_type[3] - @hand.hands_type[4]).abs == DIFFERENCE && @hand.hands_type[0] + 4 == @hand.hands_type[4]
        puts 'Straight Flush'
      else
        puts 'Flush'
      end
    elsif @array.value?(4)
      puts 'Four of a Kind'
    elsif @array.value?(3) && @array.value?(2)
      puts 'Full House'
    elsif @array.value?(3)
      puts 'Three of a Kind'
    elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && @array.values[2] == 2
      puts 'Two pair'
    elsif @array.value?(2)
      puts 'One pair'
    else
      puts 'No pair'
    end
  end
end
