test_input = <<~EOF
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
EOF
  .split("\n")

def day_1(input)
  moves = input.first.split(",").map(&:to_i)
  raw_boards = input.drop(2)
    .slice_when { |line, next_line| line == "\n" }

  boards = raw_boards
    .map do |board|
      converted = board.map { |line| line.strip.split(" ").map(&:to_i) }
      if converted.last == []
        converted.pop
      end
      converted
    end

  moves.each do |move|
    boards.each do |board|
      board.each do |line|
        line.map! { |el| el == move ? :f : el }
      end
      board.each do |line|
        if line.all?(:f)
          return move * board.flatten(1).reject { |el| el == :f }.sum
        end
      end
      board.transpose.each do |line|
        if line.all?(:f)
          return move * board.flatten(1).reject { |el| el == :f }.sum
        end
      end
    end
  end
end

def day_2(input)
  moves = input.first.split(",").map(&:to_i)
  raw_boards = input.drop(2)
    .slice_when { |line, next_line| line == "\n" }

  boards = raw_boards
    .map do |board|
      converted = board.map { |line| line.strip.split(" ").map(&:to_i) }
      if converted.last == []
        converted.pop
      end
      converted
    end

  require "set"
  won = Set.new

  moves.each do |move|
    boards.each.with_index do |board, idx|
      board.each do |line|
        line.map! { |el| el == move ? :f : el }
      end
      board.each do |line|
        if line.all?(:f)
          won << idx
          if won.size == boards.size
            return move * board.flatten(1).reject { |el| el == :f }.sum
          end
        end
      end
      board.transpose.each do |line|
        if line.all?(:f)
          won << idx
          if won.size == boards.size
            return move * board.flatten(1).reject { |el| el == :f }.sum
          end
        end
      end
    end
  end
  won.size
end

input = File.readlines("input.txt")

puts day_1(input)
puts day_2(input)
