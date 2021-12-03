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

def co2_calculator(data, position)
  return data if data.count == 1
  cols = data.transpose
  needle = "1"

  needle = "0" if cols[position].count("1") >= cols[position].count("0")

  reduced_data = data.select { |e| e[position] == needle }
  co2_calculator(reduced_data, position + 1)
end
def o2_calculator(data, position)
  return data if data.count == 1
  cols = data.transpose
  needle = "0"

  needle = "1" if cols[position].count("1") >= cols[position].count("0")

  reduced_data = data.select { |e| e[position] == needle }
  o2_calculator(reduced_data, position + 1)
end

def part2
  data = input.lines.collect { |l| l.chomp.chars }
  o2 = o2_calculator(data, 0)
  co2 = co2_calculator(data, 0)
  p o2.join.to_i(2) * co2.join.to_i(2)
end

part1
part2
