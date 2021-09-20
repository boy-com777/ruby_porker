class Player
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
    @player.hands[0] = deck.draw
    @player.hands[1] = deck.draw
    @player.hands[2] = deck.draw
    @player.hands[3] = deck.draw
    @player.hands[4] = deck.draw
    @player.show_hands = []
    @player.sho_hands << @player.hands
  end
end

# private

# def second_draw_player(deck)
#   @player.hands[0] = deck.draw if @trade.include?('1')
#   @player.hands[1] = deck.draw if @trade.include?('2')
#   @player.hands[2] = deck.draw if @trade.include?('3')
#   @player.hands[3] = deck.draw if @trade.include?('4')
#   @player.hands[4] = deck.draw if @trade.include?('5')
#   @player.show_hands = []
#   @player.show_hands << @player.hands
# end
