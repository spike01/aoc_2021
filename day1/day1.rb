test_input = <<~EOF
199
200
208
210
200
207
240
269
260
263
EOF

input = File.read("input.txt").lines

def part_1(input)
  count = 0
  tmp = 0

  input
    .map(&:to_i)
    .each.with_index do |line, i|
      count += 1 if line > tmp && i != 0
      tmp = line
  end

  count
end

def part_2(input)
  count = 0
  tmp = 0

  converted = input.map(&:to_i)

  window_sums = converted.map.with_index do |line, i|
    second_idx = i + 1
    third_idx = i + 2
    line + converted[second_idx].to_i + converted[third_idx].to_i
  end

  window_sums.each.with_index do |line, i|
    count += 1 if line > tmp && i != 0
    tmp = line
  end

  count
end

puts part_1(input)
puts part_2(input)
