def input
  File.read("input.txt")
end

def part1
  out = input.each_line.each_cons(2).count do |depths|
    depths.first.to_i < depths.last.to_i
  end

  puts "part 1: #{out}"
end

def part2
  sums = input.each_line.each_cons(3).collect do |window|
    window[0].to_i + window[1].to_i + window[2].to_i
  end

  out = sums.each_cons(2).count do |items|
    items.first < items.last
  end

  puts "part 2: #{out}"
end

part1
part2
