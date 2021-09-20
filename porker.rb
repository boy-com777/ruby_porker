# # requireで他ファイル�������参照
# require './deck'
# require './player'
# require './opponentplayer'

# class Porker
#   # 交換限度回数を2回と定義
#   PLAYER_ROLE = 2
#   OPPONENTPLAYER_ROLE = 2

#   def start
#     puts <<~TEXT
#       -------------------------------------
#       |            Porker Game            |
#       -------------------------------------
#     TEXT

#     # build_deckメソッド呼び出し
#     build_deck
#     # build_playerメソッド呼び出し
#     build_player
#     # build_opponentplayerメソッド呼び出し
#     build_opponentplayer
#     # 山札から手札を引く
#     @player.player_first_draw(@deck)
#     # 親手札柄を表示する
#     @player.hands_list
#     # 親手札の役を表示
#     @player_hand_type = player_hand_type
#     # opponentplayerクラスのopponent_player_drawにdeckを引数で渡して呼び出し
#     @opponentplayer.opponentplayer_first_draw(@deck)
#     @opponentplayer.hands_list
#     # 子手札の役を表示
#     @opponentplayer_hand_type = opponentplayer_hand_type

#     # 交換回��カウントの変数を定義、初期化
#     @player_change_count = 0
#     @opponentplayer_change_count = 0

#     while true
#       puts <<~TEXT
#         ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
#           親の手札交換の番です。
#           手札を交換しますか？選んで下さい。
#           1. 交換する
#           2. 交換しない
#         ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
#       TEXT
#       player_action = gets.chomp.to_i
#       if player_action == 1
#         puts <<~TEXT
#           交換するカードの番号を選択して下さい。
#           複数枚選択す���ことが可能です。
#           【例】
#           ・1を交換する場���� : 「1」を選択。
#           ・2と3を交換する場合 : 「2」空白スペース「3」を選択。
#         TEXT
#         while true
#           @trade = gets.chomp.split(&:to_s)
#           @change_number = Regexp.new(/^\d$|\d\s/)
#           if @change_number =~ @trade
#             second_draw(@deck)
#             break
#           else
#             puts <<~TEXT
#               交換する手札を選択し直してください。
#               複数枚選択する場合は選択する番号の間に半角スペースが必要です。
#             TEXT
#           end
#         end
#         @player.hands_list
#         @player_hand_type = player_hand_type
#         @player_change_count += 1

#         player_change_count_check
#         if @player_change_count_flag == 2
#           puts <<~TEXT
#             =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#               手札交換限度回数になりました。
#               これ以降は手札交換��き�����せ�����。
#             =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#           TEXT
#           break
#         end

#       elsif player_action == 2
#         # ループ処理を��ける
#         break

#       else
#         puts <<~TEXT
#           =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#             Error : 1か2を入力して下さい。
#           =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#         TEXT
#       end
#     end

#     while true
#       puts <<~TEXT
#         ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
#           子の手札交換の番です。
#           手札を交換しますか？選んで下さい。
#           1. 交換する
#           2. 交換しない
#         ~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~/~
#       TEXT
#       opponentplayer_action = gets.chomp.to_i
#       if opponentplayer_action == 1
#         puts <<~TEXT
#           交換するカードの番号を選択して下さい。
#           複数枚選択することが可能です。
#           【例】
#           ・1を交換する場合 : 「1」を選択。
#           ・2と3を交換する場合 : 「2」空白スペース「3」を選択。
#         TEXT
#         while true
#           @trade = gets.chomp.split(&:to_s)
#           @change_number = Regexp.new(/^\d$|\d\s/)
#           if @change_number =~ @trade
#             second_draw(@deck)
#             break
#           else
#             puts <<~TEXT
#               交換する手札を選択し直してください。
#               複数枚選択する場合は選択する番号の間に半角スペースが必要です。
#             TEXT
#           end
#         end
#         @opponentplayer.hands_list
#         @opponentplayer_hand_type = opponentplayer_hand_type
#         @opponentplayer_change_count += 1

#         opponentplayer_change_count_check
#         if @opponentplayer_change_count_flag == 2
#           puts <<~TEXT
#             =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#               手札交換限度回数になりました。
#               これ以降は手札交換できません。
#             =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#           TEXT
#           # 勝敗判定
#           judge
#           break
#         end

#       elsif opponentplayer_action == 2
#         # 勝敗判定
#         judge
#         # ル��プ処理を抜ける
#         break

#       else
#         puts <<~TEXT
#           =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#             Error : 1か2を入力して下さい。
#           =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=
#         TEXT
#       end
#     end
#   end

#   def player_change_count_check
#     @player_change_count_flag = 2 if @player_change_count == PLAYER_ROLE
#   end

#   def opponentplayer_change_count_check
#     @opponentplayer_change_count_flag = 2 if @opponentplayer_change_count == OPPONENTPLAYER_ROLE
#   end

#   private

#   def build_deck
#     @deck = Deck.new
#   end

#   def build_player
#     @player = Player.new
#   end

#   def player_hand_type
#     @player.sum_hands = @player.show_hands.flatten!
#     @spade = @player.sum_hands.count('スペイド')
#     @heart = @player.sum_hands.count('ハート')
#     @diamond = @player.sum_hands.count('ダイア')
#     @clober = @player.sum_hands.count('クラブ')

#     @player.sum_hands.delete('スペイド')
#     @player.sum_hands.delete('ハート')
#     @player.sum_hands.delete('ダイア')
#     @player.sum_hands.delete('クラブ')
#     @player.sum_hands.sort!

#     puts <<~TEXT
#       -------------------------------------
#       |           親 : 現在の役           |
#       -------------------------------------
#     TEXT

#     @array = @player.sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
#     if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
#       if @player.show_hands[0] == 1 && @player.show_hands[1] == 10 && @player.show_hands[2] == 11 && @player.show_hands[3] == 12 && @player.show_hands[3] == 13
#         puts 'Royal Straight Flush'
#         @player_judge_hand_type = 10
#       elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_handds[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
#         puts 'Straight Flush'
#         @player_judge_hand_type = 9
#       else
#         puts 'Flush'
#         @player_judge_hand_type = 6
#       end
#     elsif @array.value?(4)
#       puts 'Four of a Kind'
#       @player_judge_hand_type = 8
#     elsif @array.value?(3) && @array.value?(2)
#       puts 'Full House'
#       @player_judge_hand_type = 7
#     elsif (@player.show_hands[0] - @player.show_hands[1]).abs == 1 && (@player.show_hands[1] - @player.show_hands[2]).abs == 1 && (@player.show_hands[2] - @player.show_hands[3]).abs == 1 && (@player.show_handds[3] - @player.show_hands[4]).abs == 1 && @player.show_hands[0] + 4 == @player.show_hands[4]
#       puts 'Straight'
#       @player_judge_hand_type = 5
#     elsif @array.value?(3)
#       puts 'Three of a Kind'
#       @player_judge_hand_type = 4
#     elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && array.values[2] == 2
#       puts 'Two pair'
#       @player_judge_hand_type = 3
#     elsif @array.value?(2)
#       puts 'One pair'
#       @player_judge_hand_type = 2
#     else
#       puts 'No pair'
#       @player_judge_hand_type = 1
#     end
#   end

#   def build_opponentplayer
#     @opponentplayer = OpponentPlayer.new
#   end

#   def opponentplayer_hand_type
#     @opponentplayer.sum_hands = @opponentplayer.show_hands.flatten!
#     @spade = @opponentplayer.sum_hands.count('スペイド')
#     @heart = @opponentplayer.sum_hands.count('ハート')
#     @diamond = @opponentplayer.sum_hands.count('ダイア')
#     @clober = @opponentplayer.sum_hands.count('クラブ')

#     @opponentplayer.sum_hands.delete('スペイド')
#     @opponentplayer.sum_hands.delete('ハート')
#     @opponentplayer.sum_hands.delete('ダイア')
#     @opponentplayer.sum_hands.delete('クラブ')
#     @opponentplayer.sum_hands.sort!

#     puts <<~TEXT
#       -------------------------------------
#       |           子 : 現在の役           |
#       -------------------------------------
#     TEXT

#     @array = @opponentplayer.sum_hands.group_by(&:itself).map { |k, v| [k, v.count] }.to_h
#     if @spade == 5 || @heart == 5 || @diamond == 5 || @clober == 5
#       if @opponentplayer.show_hands[0] == 1 && @opponentplayer.show_hands[1] == 10 && @opponentplayer.show_hands[2] == 11 && @opponentplayer.show_hands[3] == 12 && @opponentplayer.show_hands[3] == 13
#         puts 'Royal Straight Flush'
#         @opponentplayer_judge_hand_type = 10
#       elsif (@opponentplayer.show_hands[0] - @opponentplayer.show_hands[1]).abs == 1 && (@opponentplayer.show_hands[1] - @opponentplayer.show_hands[2]).abs == 1 && (@opponentplayer.show_hands[2] - @opponentplayer.show_hands[3]).abs == 1 && (@opponentplayer.show_handds[3] - @opponentplayer.show_hands[4]).abs == 1 && @opponentplayer.show_hands[0] + 4 == @opponentplayer.show_hands[4]
#         puts 'Straight Flush'
#         @opponentplayer_judge_hand_type = 9
#       else
#         puts 'Flush'
#         @opponentplayer_judge_hand_type = 6
#       end
#     elsif @array.value?(4)
#       puts 'Four of a Kind'
#       @opponentplayer_judge_hand_type = 8
#     elsif @array.value?(3) && @array.value?(2)
#       puts 'Full House'
#       @opponentplayer_judge_hand_type = 7
#     elsif (@opponentplayer.show_hands[0] - @opponentplayer.show_hands[1]).abs == 1 && (@opponentplayer.show_hands[1] - @opponentplayer.show_hands[2]).abs == 1 && (@opponentplayer.show_hands[2] - @opponentplayer.show_hands[3]).abs == 1 && (@opponentplayer.show_handds[3] - @opponentplayer.show_hands[4]).abs == 1 && @opponentplayer.show_hands[0] + 4 == @opponentplayer.show_hands[4]
#       puts 'Straight'
#       @opponentplayer_judge_hand_type = 5
#     elsif @array.value?(3)
#       puts 'Three of a Kind'
#       @opponentplayer_judge_hand_type = 4
#     elsif @array.values[0] == 2 && @array.values[1] == 2 || @array.values[1] == 2 && @array.values[2] == 2 || @array.values[0] == 2 && array.values[2] == 2
#       puts 'Two Pair'
#       @opponentplayer_judge_hand_type = 3
#     elsif @array.value?(2)
#       puts 'One Pair'
#       @opponentplayer_judge_hand_type = 2
#     else
#       puts 'No Pair'
#       @opponentplayer_judge_hand_type = 1
#     end
#   end

#   def judge
#     puts <<~TEXT
#       -------------------------------------
#       |                勝敗               |
#       -------------------------------------
#     TEXT
#     if @player_judge_hand_type > @opponentplayer_judge_hand_type
#       puts <<~TEXT
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#           親の勝利です！
#           おめでとうございます！
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#       TEXT
#     elsif @player_judge_hand_type < @opponentplayer_judge_hand_type
#       puts <<~TEXT
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#           子の勝利です！
#           おめでとうございます！
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#       TEXT
#     else
#       puts <<~TEXT
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#           引き分けです・・・
#         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#       TEXT
#     end
#   end
# end

require './deck'
require './player'
require './opponentplayer'
require './message'

class Porker
  include Message

  # 交換限度回数を2回と定義
  PLAYER_ROLE = 2
  OPPONENTPLAYER_ROLE = 2

  def start
    start_message
    while true
      # build_deckメソッド呼び出し
      build_deck

      # build_playerメソッド呼び出し
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

      # 交換回数カウントの変数を定義、初期化
      @change_count_player = 0
      @change_count_opponent = 0

      while true
        information1

        action_player = gets.chomp.to_i
        if action_player == 1
          information2
          while true
            @change_number = gets.chomp.split(&:to_s)
            @change = Regexp.new(/^\d$|\d\s/)
            if @change =~ @change_number
              @player.second_draw_player(@deck) if @change_number.include?('1')
              @player.second_draw_player(@deck) if @change_number.include?('2')
              @player.second_draw_player(@deck) if @change_number.include?('3')
              @player.second_draw_player(@deck) if @change_number.include?('4')
              @player.second_draw_player(@deck) if @change_number.include?('5')
            else
              information3
            end
          end

        elsif action_player == 2
          # 対戦相手手札交換
          information4
          action_opponent = gets.chomp.to_i
          if action_opponent == 1
            while true
              @change_number = gets.chomp.split(&:to_s)
              @change = Regexp.new(/^\d$|\d\s/)
              if @change =~ @change_number
                second_draw_opponent(@deck)
              else
                information3
              end
            end
          elsif action_opponent == 2
            break
          end
        end
      end
      break if action_player == 2 && action_opponent == 2
    end
  end
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
