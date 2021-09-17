class Player
  attr_accessor :hands, :sum_hands, :show_hands

  # 手札5枚引くのを定数で定義
  NUMBER_OF_HAND = 5

  def initialize
    @hands = []
  end

  # 手札を山札から引く
  def player_first_draw(deck)
    NUMBER_OF_HAND.times do
      card = deck.draw
      @hands << card
    end

    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end

    puts '=*=*=*=*=*=*= 親 手札 =*=*=*=*=*=*=*='
    @hands.each.with_index(1) do |hand, i|
      puts "#{i}. #{hand[0]}の#{hand[1]}"
    end
  end

  def second_draw_one(deck)
    @hands[0].delete(@hands[0][0])
    @hands[0].delete(@hands[0][0])
    card = deck.draw
    @hands[0] << card
    @hands[0].flatten!
    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def second_draw_two(deck)
    @hands[1].delete(@hands[1][0])
    @hands[1].delete(@hands[1][0])
    card = deck.draw
    @hands[1] << card
    @hands[1].flatten!
    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def second_draw_three(deck)
    @hands[2].delete(@hands[2][0])
    @hands[2].delete(@hands[2][0])
    card = deck.draw
    @hands[2] << card
    @hands[2].flatten!
    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def second_draw_four(deck)
    @hands[3].delete(@hands[3][0])
    @hands[3].delete(@hands[3][0])
    card = deck.draw
    @hands[3] << card
    @hands[3].flatten!
    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def second_draw_five(deck)
    @hands[4].delete(@hands[4][0])
    @hands[4].delete(@hands[4][0])
    card = deck.draw
    @hands[4] << card
    @hands[4].flatten!
    @show_hands = []
    @hands.each do |hand|
      @show_hands << hand
    end
  end

  def hands_show_player
    puts <<~TEXT
      1. #{@hands[0][0]}の#{@hands[0][1]}
      2. #{@hands[1][0]}の#{@hands[1][1]}
      3. #{@hands[2][0]}の#{@hands[2][1]}
      4. #{@hands[3][0]}の#{@hands[3][1]}
      5. #{@hands[4][0]}の#{@hands[4][1]}
    TEXT
  end
end
