test_input = <<-EOF
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
EOF
  .split("\n")

class Point
  def initialize(x, y)
    @x = x
    @y = y
  end
  attr_reader :x, :y

  def ==(other)
    x = other.x && y = other.y
  end

  def eql?(other)
    self == other
  end

  def hash
    [x, y].hash
  end

  def to_s
    "#{x},#{y}"
  end
end

def day_1(input)
  points = Hash.new { 0 }
  input.each do |line|
    from, to = line.split(" -> ")
    from_x, from_y = from.split(",").map(&:to_i)
    to_x, to_y = to.split(",").map(&:to_i)

    # Swap so ranges behave correctly
    from_x, to_x = to_x, from_x if to_x < from_x
    from_y, to_y = to_y, from_y if to_y < from_y

    if from_x == to_x
      (from_y..to_y).each do |y|
        point = Point.new(from_x, y)
        points[point] = points[point] += 1
      end
    end

    if from_y == to_y
      (from_x..to_x).each do |x|
        point = Point.new(x, from_y)
        points[point] = points[point] += 1
      end
    end
  end

  points.select { |_, v| v >= 2 }.count
end

def day_2(input)
  points = Hash.new { 0 }

  input.each do |line|
    from, to = line.split(" -> ")
    from_x, from_y = from.split(",").map(&:to_i)
    to_x, to_y = to.split(",").map(&:to_i)


    # Diagonals
    if from_x != to_x && from_y != to_y
      curr_point = Point.new(from_x, from_y)
      target_point = Point.new(to_x, to_y)
      # Write first point
      points[curr_point] = points[curr_point] + 1

      loop do
        x = if curr_point.x > to_x
          curr_point.x - 1
        else
          curr_point.x + 1
        end
        y = if curr_point.y > to_y
          curr_point.y - 1
        else
          curr_point.y + 1
        end
        curr_point = Point.new(x, y)
        points[curr_point] = points[curr_point] + 1
        break if x == target_point.x && y = target_point.y
      end
      next
    end

    # Swap so ranges behave correctly
    from_x, to_x = to_x, from_x if to_x < from_x
    from_y, to_y = to_y, from_y if to_y < from_y

    # Vertical lines
    if from_x == to_x
      (from_y..to_y).each do |y|
        point = Point.new(from_x, y)
        points[point] = points[point] += 1
      end
    end

    # Horizontal lines
    if from_y == to_y
      (from_x..to_x).each do |x|
        point = Point.new(x, from_y)
        points[point] = points[point] += 1
      end
    end
  end

  points.select { |_, v| v >= 2 }.count
end

input = File.readlines("input.txt")

pp day_1(input)
pp day_2(input)
