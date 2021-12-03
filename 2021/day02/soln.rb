def input
  File.read("input.txt").lines.map(&:split).map {|k, v| [k, v.to_i]}
end

def part1
  position = input.inject({h: 0, d: 0}) do |acc, instruction|
    acc[:h] += instruction.last if instruction.first == "forward"
    acc[:d] += instruction.last if instruction.first == "down"
    acc[:d] -= instruction.last if instruction.first == "up"
    acc
  end
  puts position[:h] * position[:d]
end

def part2
  position = input.inject({h: 0, d: 0, a: 0}) do |acc, vector|
    acc[:h] += vector.last if vector.first == "forward"
    acc[:d] += acc[:a] * vector.last if vector.first == "forward"
    acc[:a] += vector.last if vector.first == "down"
    acc[:a] -= vector.last if vector.first == "up"
    acc
  end
  puts position[:h] * position[:d]
end

part1
part2
