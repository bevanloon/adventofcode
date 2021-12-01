def input
  File.read("input.txt")
end

def part1
  inc = 0
  input.each_line.each_cons(2) do |depths|
    inc += 1 if depths.first.to_i < depths.last.to_i
  end
  puts "part 1: #{inc}"
end

def part2
  sums = input.each_line.each_cons(3).collect do |window|
    window[0].to_i + window[1].to_i + window[2].to_i
  end

  inc = 0
  sums.each_cons(2) do |items|
    inc += 1 if items.first < items.last
  end
  puts "part 2: #{inc}"
end

part1
part2
