class OpponentPlayer < Player
  attr_accessor :hands, :sum_hands, :show_hands

  # 手札を山札から引く
  def opponentplayer_first_draw(deck)
    5.times do
      card = deck.draw
      @hands << card
    end

    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def hands_list
    puts '=*=*=*=*=*=*= 相手プレイヤー 手札 =*=*=*=*=*=*=*='
    @hands.each.with_index(1) do |hand, i|
      puts "#{i}. #{hand[0]}の#{hand[1]}"
    end
  end
end

private

def second_draw(deck)
  @opponentplayer.hands[0] = deck.draw if @trade.include?('1')
  @opponentplayer.hands[1] = deck.draw if @trade.include?('2')
  @opponentplayer.hands[2] = deck.draw if @trade.include?('3')
  @opponentplayer.hands[3] = deck.draw if @trade.include?('4')
  @opponentplayer.hands[4] = deck.draw if @trade.include?('5')
  @opponentplayer.show_hands = []
  @opponentplayer.show_hands << @player.hands
end
