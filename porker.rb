# requireで他ファイルを参照
require './deck'
require './player'
require './opponentplayer'

class Porker
  # 交換限度回数を2回と定義
  PLAYER_ROLE = 2
  OPPONENTPLAYER_ROLE = 2

  def start
    puts <<~TEXT
      -------------------------------------
      |            Porker Game            |
      -------------------------------------
    TEXT

    # build_deckメソッド呼び出し
    build_deck
    # build_playerメソッド呼び出し
    build_player
    # build_opponentplayerメソッド呼び出し
    build_opponentplayer
    # build_deckメソッド���び出し
    @player.player_first_draw(@deck)
    # 親手札の役を表示
    @player_hand_type = player_hand_type
    # opponentplayerクラスのopponent_player_drawにdeckを引数で渡して呼び出し
    @opponentplayer.opponentplayer_first_draw(@deck)
    # 小手札の役を表示
    @opponentplayer_hand_type = opponentplayer_hand_type

    # 交換回��カウントの変数を定義、初期化
    @player_change_count = 0
    @opponentplayer_change_count = 0

    while true
      puts <<~TEXT
        ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
          親の手札交換の番です。
          手札を交換しますか？選んで下さい。
          1. 交換する
          2. 交換しない
        ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
      TEXT
      player_action = gets.chomp.to_i
      if player_action == 1
        puts <<~TEXT
          交換するカードの番号を選択して下さい。
          複数枚選択することが可能です。
          【例】
          ・1を交換する場合 : 「1」を選択。
          ・2と3を交換する場合 : 「2」空白スペース「3」を選択。
        TEXT
        @trade = gets.chomp.split.map(&:to_s)
        @player.second_draw_one(@deck) if @trade.include?('1')
        @player.second_draw_two(@deck) if @trade.include?('2')
        @player.second_draw_three(@deck) if @trade.include?('3')
        @player.second_draw_four(@deck) if @trade.include?('4')
        @player.second_draw_five(@deck) if @trade.include?('5')
        @player.hands_show_player
        @player_hand_type = player_hand_type
        @player_change_count += 1

        player_change_count_check
        if @player_change_count_flag == 2
          puts <<~TEXT
            =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
              手札交換限度回数になりました。
              これ以降は手札交換できません。
            =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
          TEXT
          break
        end

      elsif player_action == 2
        # ループ処理を抜ける
        break

      else
        puts <<~TEXT
          =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
            Error : 1か2を入力して下さい。
          =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
        TEXT
      end
    end

    while true
      puts <<~TEXT
        ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
          子の手札交換の番です。
          手札を交換しますか？選んで下さい。
          1. 交換する
          2. 交換しない
        ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
      TEXT
      opponentplayer_action = gets.chomp.to_i
      if opponentplayer_action == 1
        puts <<~TEXT
          交換するカードの番号を選択して下さい。
          複数枚選択することが可能です。
          【例】
          ・1を交換する場合 : 「1」を選択。
          ・2と3を交換する場合 : 「2」空白スペース「3」を選択。
        TEXT
        @trade = gets.chomp.split.map(&:to_s)
        @opponentplayer.second_draw_one(@deck) if @trade.include?('1')
        @opponentplayer.second_draw_two(@deck) if @trade.include?('2')
        @opponentplayer.second_draw_three(@deck) if @trade.include?('3')
        @opponentplayer.second_draw_four(@deck) if @trade.include?('4')
        @opponentplayer.second_draw_five(@deck) if @trade.include?('5')
        @opponentplayer.hands_show_player
        @opponentplayer_hand_type = opponentplayer_hand_type
        @opponentplayer_change_count += 1

        opponentplayer_change_count_check
        if @opponentplayer_change_count_flag == 2
          puts <<~TEXT
            =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
              手札交換限度回数になりました。
              これ以降は手札交換できません。
            =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
          TEXT
          # 勝敗判定
          judge
          break
        end

      elsif opponentplayer_action == 2
        # 勝敗判定
        judge
        # ループ処理を抜ける
        break

      else
        puts <<~TEXT
          =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
            Error : 1か2を入力して下さい。
          =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
        TEXT
      end
    end
  end

  def player_change_count_check
    @player_change_count_flag = 2 if @player_change_count == PLAYER_ROLE
  end

  def opponentplayer_change_count_check
    @opponentplayer_change_count_flag = 2 if @opponentplayer_change_count == OPPONENTPLAYER_ROLE
  end

  private

  def build_deck
    @deck = Deck.new
  end

  def build_player
    @player = Player.new
  end

  def player_hand_type
    @player.sum_hands = @player.show_hands.flatten!
    @spade = @player.sum_hands.count('スペイド')
    @heart = @player.sum_hands.count('ハート')
    @diamond = @player.sum_hands.count('ダイア')
    @clober = @player.sum_hands.count('クラブ')

    @player.sum_hands.delete('スペイド')
    @player.sum_hands.delete('ハート')
    @player.sum_hands.delete('ダイア')
    @player.sum_hands.delete('クラブ')
    @player.sum_hands.sort!

    puts <<~TEXT
      -------------------------------------
      |           親 : 現在の役           |
      -------------------------------------
    TEXT

    @array = @player.sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
    if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
      if @player.show_hands[0] == 1 && @player.show_hands[1] == 10 && @player.show_hands[2] == 11 && @player.show_hands[3] == 12 && @player.show_hands[3] == 13
        puts 'Royal Straight Flush'
        @player_judge_hand_type = 10
      elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_handds[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
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
    elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_handds[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
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

  def build_opponentplayer
    @opponentplayer = OpponentPlayer.new
  end

  def opponentplayer_hand_type
    @opponentplayer.sum_hands = @opponentplayer.show_hands.flatten!
    @spade = @opponentplayer.sum_hands.count('スペイド')
    @heart = @opponentplayer.sum_hands.count('ハート')
    @diamond = @opponentplayer.sum_hands.count('ダイア')
    @clober = @opponentplayer.sum_hands.count('クラブ')

    @opponentplayer.sum_hands.delete('スペイド')
    @opponentplayer.sum_hands.delete('ハート')
    @opponentplayer.sum_hands.delete('ダイア')
    @opponentplayer.sum_hands.delete('クラブ')
    @opponentplayer.sum_hands.sort!

    puts <<~TEXT
      -------------------------------------
      |           子 : 現在の役           |
      -------------------------------------
    TEXT

    @array = @opponentplayer.sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
    if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
      if @opponentplayer.show_hands[0] == 1 && @opponentplayer.show_hands[1] == 10 && @opponentplayer.show_hands[2] == 11 && @opponentplayer.show_hands[3] == 12 && @opponentplayer.show_hands[3] == 13
        puts 'Royal Straight Flush'
        @opponentplayer_judge_hand_type = 10
      elsif (@opponentplayer.show_hands[0] - @opponentplayer.show_hands[1]).abs == 1 && (@opponentplayer.show_hands[1] - @opponentplayer.show_hands[2]).abs == 1 && (@opponentplayer.show_hands[2] - @opponentplayer.show_hands[3]).abs == 1 && (@opponentplayer.show_handds[3] - @opponentplayer.show_hands[4]).abs == 1 && @opponentplayer.show_hands[0] + 4 == @opponentplayer.show_hands[4]
        puts 'Straight Flush'
        @opponentplayer_judge_hand_type = 9
      else
        puts 'Flush'
        @opponentplayer_judge_hand_type = 6
      end
    elsif @array.value?(4)
      puts 'Four of a Kind'
      @opponentplayer_judge_hand_type = 8
    elsif @array.value?(3) && @array.value?(2)
      puts 'Full House'
      @opponentplayer_judge_hand_type = 7
    elsif (@opponentplayer.show_hands[0] - @opponentplayer.show_hands[1]).abs == 1 && (@opponentplayer.show_hands[1] - @opponentplayer.show_hands[2]).abs == 1 && (@opponentplayer.show_hands[2] - @opponentplayer.show_hands[3]).abs == 1 && (@opponentplayer.show_handds[3] - @opponentplayer.show_hands[4]).abs == 1 && @opponentplayer.show_hands[0] + 4 == @opponentplayer.show_hands[4]
      puts 'Straight'
      @opponentplayer_judge_hand_type = 5
    elsif @array.value?(3)
      puts 'Three of a Kind'
      @opponentplayer_judge_hand_type = 4
    elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && array.values[2] == 2
      puts 'Two Pair'
      @opponentplayer_judge_hand_type = 3
    elsif @array.value?(2)
      puts 'One Pair'
      @opponentplayer_judge_hand_type = 2
    else
      puts 'No Pair'
      @opponentplayer_judge_hand_type = 1
    end
  end

  def judge
    puts <<~TEXT
      -------------------------------------
      |                勝敗               |
      -------------------------------------
    TEXT
    if @player_judge_hand_type > @opponentplayer_judge_hand_type
      puts <<~TEXT
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
          親の勝利です！
          おめでとうございます！
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
      TEXT
    elsif @player_judge_hand_type < @opponentplayer_judge_hand_type
      puts <<~TEXT
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
          子の勝利です！
          おめでとうございます！
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
      TEXT
    else
      puts <<~TEXT
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
          引き分けです・・・
        *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
      TEXT
    end
  end
end
