test_input = <<-EOF
forward 5
down 5
forward 8
up 3
down 8
forward 2
EOF
  .split("\n")

input = File.readlines("input.txt")

def part_1(input)
  x = 0
  y = 0

  input.each do |line|
    direction, size = line.split(" ")
    case direction
    when "forward"
      x = x + size.to_i
    when "up" 
      y = y - size.to_i
    when "down"
      y = y + size.to_i
    end
  end

  x * y
end

def part_2(input)
  x = 0
  y = 0
  aim = 0

  input.each do |line|
    direction, size = line.split(" ")
    case direction
    when "forward"
      x = x + size.to_i
      y = y + (aim * size.to_i)
    when "up"
      aim = aim - size.to_i
    when "down"
      aim = aim + size.to_i
    end
  end

  x * y
end

puts part_1(input)
puts part_2(input)
