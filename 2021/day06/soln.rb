def input
  File.read("input.txt").chomp.split(",").map(&:to_i)
end

def a
  cycles = 80
  lantern_fish = input

  cycles.times do |n|
    (lantern_fish.length - 1).downto(0) do |index|
      fish = lantern_fish[index]
      if fish.zero?
        lantern_fish << 8
        lantern_fish[index] = 6
      else
        lantern_fish[index] -= 1
      end
    end
  end
  p lantern_fish.length
end

def b
  fishy = Hash.new(0)
  input.each do |elem|
    fishy[elem] += 1
  end
  256.times do |n|
    temp = {}
    0.upto(7) do |n|
      temp[n] = fishy[n + 1]
    end
    temp[6] += fishy[0]
    temp[8] = fishy[0]
    fishy = temp.dup
  end
  puts fishy.values.inject(0) {|acc, v| acc += v }
end

def with_array(cycles)
  fishy = Array.new(9) {0}
  input.each do |fish|
    fishy[fish] += 1
  end

  cycles.times do |n|
    fishy.rotate!
    fishy[6] += fishy.last
  end
  p fishy.sum
end

with_array(80)
with_array(256)
a
b
