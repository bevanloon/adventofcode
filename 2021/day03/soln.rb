def input
  File.read("input.txt")
end

def cols
  input.lines.collect do |line|
    line.chomp.split("")
  end.transpose
end

def part1
  gamma = []
  epsilon = []
  cols.collect do |col|
    if col.count("1") > col.count("0")
      gamma << 1
      epsilon << 0
    else
      gamma << 0
      epsilon << 1
    end
  end
  puts gamma.join.to_i(2)
  puts epsilon.join.to_i(2)
  puts gamma.join.to_i(2) * epsilon.join.to_i(2)
end

def calc(data, position, bit_counter)
  return data if data.count == 1
  cols = data.transpose
  next_set = data.select { |e| e[position] == bit_counter.call(cols[position]) }
  calc(next_set, position + 1, bit_counter)
end

def part2
  data = input.lines.collect { |l| l.chomp.chars }

  o2_bits = lambda do  |cols|
    return "1" if cols.count("1") >= cols.count("0")
    return "0"
  end

  co2_bits = lambda do |cols|
    return "0" if cols.count("1") >= cols.count("0")
    return "1"
  end

  o2 = calc(data, 0, o2_bits)
  co2 = calc(data, 0, co2_bits)
  p o2.join.to_i(2) * co2.join.to_i(2)
end

part1
part2
