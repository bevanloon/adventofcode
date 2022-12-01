filename = "input.txt"
data = File.read(filename).lines
polymer = data.shift.chomp
data.shift # remove empty line
template = data.inject({}) do |acc, line|
  pair = line.chomp.split(" -> ")
  acc[pair[0]] = pair[1]
  acc
end

def insertion(polymer, template)
  ins = polymer.chars.each_cons(2).collect do |pair|
    [pair[0], template[pair.join]]
  end
  ins << polymer.chars.last
  ins.flatten.join
end

fin = 40.times.inject(polymer) do |p, _|
  insertion(p, template)
end

# catch the last character
chars_to_count = fin.chars.tally

min = chars_to_count.min_by { |char, count| count }
max = chars_to_count.max_by { |char, count| count }

p max[1] - min[1]

