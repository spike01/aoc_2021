test_input = <<-EOF
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
EOF
  .split("\n")

input = File.readlines("input.txt")

def day_1(input)
  transposed = input.map { |line| line.strip.split("").map(&:to_i) }
    .transpose

  gamma_rate_bits = transposed.map { |bits| most_common_bit(bits) }
  epsilon_rate_bits = transposed.map { |bits| least_common_bit(bits) }

  gamma_rate = "0b#{gamma_rate_bits.join("")}".to_i(2)
  epsilon_rate = "0b#{epsilon_rate_bits.join("")}".to_i(2)

  gamma_rate * epsilon_rate
end

def most_common_bit(bits)
  ones = bits.count(1)
  zeros = bits.count(0)
  return "1" if ones >= zeros
  "0"
end

def least_common_bit(bits)
  ones = bits.count(1)
  zeros = bits.count(0)
  return "0" if ones > zeros
  return "0" if ones == zeros
  "1"
end

def day_2(input)
  transposed = input.map { |line| line.strip.split("").map(&:to_i) }
    .transpose

  o2 = "0b#{oxygen_generator_rating(input)}".to_i(2)
  co2 = "0b#{co2_scrubber_rating(input)}".to_i(2)

  o2 * co2
end

def oxygen_generator_rating(input)
  tmp = input
  input.size.times do |idx|
    filter = tmp.map { |line| line.strip.split("").map(&:to_i) }
      .transpose
      .map { |bits| most_common_bit(bits) }

    tmp = tmp.select { |line| line[idx] == filter[idx] }
    return tmp.first if tmp.size == 1
  end
  tmp.first
end

def co2_scrubber_rating(input)
  tmp = input
  input.size.times do |idx|
    filter = tmp.map { |line| line.strip.split("").map(&:to_i) }
      .transpose
      .map { |bits| least_common_bit(bits) }

    tmp = tmp.select { |line| line[idx] == filter[idx] }
    return tmp.first if tmp.size == 1
  end
  tmp.first
end


puts day_1(input)
puts day_2(input)
