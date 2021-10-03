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
    display_hands
    # @hand.hands_list
    hands_list
    @hand.hand_type
  end

  private

  def build_deck
    @deck = Deck.new
  end

  def build_hand
    @hand = Hand.new
  end

  # royal straight flushのマークカウントを定数化
  FIVE_SAME_MARK = 5

  def hand_type
    # マークの数を集計
    @sum_hands = @hands_type
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
  end
end
