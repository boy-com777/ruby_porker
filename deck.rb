class Deck
  def initialize
    @cards = []

    marks = %w[スペイド ハート ダイア クラブ]
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

    marks.each do |mark|
      numbers.each do |number|
        @cards << [mark, number]
      end
    end

    @cards.shuffle!
  end

  def draw
    @cards.shift
  end
end
