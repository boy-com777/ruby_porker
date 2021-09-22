require './deck'
require './player'
require './opponentplayer'
require './message'

class Porker
  include Message

  # 交換限度回数を2回と定義
  PLAYER_ROLE = 2
  OPPONENT_ROLE = 2

  def start
    start_message
    # build_deckメソッド呼び出し
    build_deck

    # build_playerメソッド��び出し
    build_player

    # build_opponentメソッド呼び出し
    build_opponent

    # プレイヤー山札から手札を引く
    @player.first_draw_player(@deck)

    # プレイヤーの手札を表示
    @player.hands_list_player

    # プレイヤーの役を表示
    @player_hand_type = hand_type_player

    # 対戦相手山札から手札を引く
    @opponent.first_draw_opponent(@deck)

    # 対戦相手の手札を表示
    @opponent.hands_list_opponent

    # 対戦相手の役を表示
    @opponent_hand_type = hand_type_opponent

    # 交換回数��ウントの変数を定義、初期化
    @change_count_player = 0
    @change_count_opponent = 0

    while true
      information1

      action_player = gets.chomp.to_i
      if action_player == 1
        while true
          @player.second_draw_player(@deck)
          @player.hands_list_player
          @player_hand_type = hand_type_player
          @change_count_player += 1
          player_change_count_check
          if @player_change_count_flag == 2
            information5
            break
          end
        end

      elsif action_player == 2
        # 対戦相手手札交換
        while true
          information4
          action_opponent = gets.chomp.to_i
          if action_opponent == 1
            while true
              @opponent.second_draw_opponent(@deck)
              @opponent.hands_list_opponent
              @opponent_hand_type = hand_type_opponent
              @change_count_opponent += 1
              opponent_change_count_check
              if @opponent_change_count_flag == 2
                information5
                break
              end
            end
          elsif action_opponent == 2
            break
          end
        end
      else
        information6
      end
      break if action_player == 2 && action_opponent == 2
    end
    judge
  end

  def player_change_count_check
    @player_change_count_flag = 2 if @change_count_player == PLAYER_ROLE
  end

  def opponent_change_count_check
    @opponent_change_count_flag = 2 if @change_count_opponent == OPPONENT_ROLE
  end

  private

  def build_deck
    @deck = Deck.new
  end

  def build_player
    @player = Player.new
  end

  def build_opponent
    @opponent = Opponent.new
  end

  def hand_type_player
    # スートの数を集計
    @sum_hands = @player.show_hands.flatten!
    @spade = @sum_hands.count('スペイド')
    @heart = @sum_hands.count('ハート')
    @diamond = @sum_hands.count('ダイア')
    @clober = @sum_hands.count('クラブ')

    # スートを削除し数字のみに
    @sum_hands.delete('スペイド')
    @sum_hands.delete('ハート')
    @sum_hands.delete('ダイア')
    @sum_hands.delete('クラブ')
    @sum_hands.sort!

    puts <<~TEXT
      -------------------------------------
      |      プレイヤー : 現在の役        |
      -------------------------------------
    TEXT

    @array = @sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
    if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
      if @player.show_hands[0] == 1 && @player.show_hands[1] == 10 && @player.show_hands[2] == 11 && @player.show_hands[3] == 12 && @player.show_hands[3] == 13
        puts 'Royal Straight Flush'
        @player_judge_hand_type = 10
      elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_hands[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
        puts 'Straight Flush'
        @player_judge_hand_type = 9
      else
        puts 'Flush'
        @player_judge_hand_type = 6
      end
    elsif @array.value?(4)
      puts 'Four of a Kind'
      @player_judge_hand_type = 8
    elsif @array.value?(3) && @array.value?(2)
      puts 'Full House'
      @player_judge_hand_type = 7
    elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_hands[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
      puts 'Straight'
      @player_judge_hand_type = 5
    elsif @array.value?(3)
      puts 'Three of a Kind'
      @player_judge_hand_type = 4
    elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && array.values[2] == 2
      puts 'Two pair'
      @player_judge_hand_type = 3
    elsif @array.value?(2)
      puts 'One pair'
      @player_judge_hand_type = 2
    else
      puts 'No pair'
      @player_judge_hand_type = 1
    end
  end

  def hand_type_opponent
    # スートの数を集計
    @sum_hands = @opponent.show_hands.flatten!
    @spade = @sum_hands.count('スペイド')
    @heart = @sum_hands.count('ハート')
    @diamond = @sum_hands.count('ダイア')
    @clober = @sum_hands.count('クラブ')

    # スートを削除し数字のみに
    @sum_hands.delete('スペイド')
    @sum_hands.delete('ハート')
    @sum_hands.delete('ダイア')
    @sum_hands.delete('クラブ')
    @sum_hands.sort!

    puts <<~TEXT
      -------------------------------------
      |      対戦相手 : 現在の役          |
      -------------------------------------
    TEXT

    @array = @sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
    if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
      if @opponent.show_hands[0] == 1 && @opponent.show_hands[1] == 10 && @opponent.show_hands[2] == 11 && @opponent.show_hands[3] == 12 && @opponent.show_hands[3] == 13
        puts 'Royal Straight Flush'
        @opponent_judge_hand_type = 10
      elsif (@opponent.show_hands[0] - @opponent.show_hands[1]).abs == 1 && (@opponent.show_hands[1] - @opponent.show_hands[2]).abs == 1 && (@opponent.show_hands[2] - @opponent.show_hands[3]).abs == 1 && (@opponent.show_handds[3] - @opponent.show_hands[4]).abs == 1 && @opponent.show_hands[0] + 4 == @opponent.show_hands[4]
        puts 'Straight Flush'
        @opponent_judge_hand_type = 9
      else
        puts 'Flush'
        @opponent_judge_hand_type = 6
      end
    elsif @array.value?(4)
      puts 'Four of a Kind'
      @opponent_judge_hand_type = 8
    elsif @array.value?(3) && @array.value?(2)
      puts 'Full House'
      @opponent_judge_hand_type = 7
    elsif (@opponent.show_hands[0] - @opponent.show_hands[1]).abs == 1 && (@opponent.show_hands[1] - @opponent.show_hands[2]).abs == 1 && (@opponent.show_hands[2] - @opponent.show_hands[3]).abs == 1 && (@opponent.show_handds[3] - @opponent.show_hands[4]).abs == 1 && @opponent.show_hands[0] + 4 == @opponent.show_hands[4]
      puts 'Straight'
      @opponent_judge_hand_type = 5
    elsif @array.value?(3)
      puts 'Three of a Kind'
      @opponent_judge_hand_type = 4
    elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && array.values[2] == 2
      puts 'Two Pair'
      @opponent_judge_hand_type = 3
    elsif @array.value?(2)
      puts 'One Pair'
      @opponent_judge_hand_type = 2
    else
      puts 'No Pair'
      @opponent_judge_hand_type = 1
    end
  end

  def judge
    information7

    if @player_judge_hand_type > @opponent_judge_hand_type
      information8
    elsif @player_judge_hand_type < @opponent_judge_hand_type
      information9
    else
      information10
    end
  end
end
