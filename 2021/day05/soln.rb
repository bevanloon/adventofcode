def input
  File.read("in.txt").lines.collect do |l|
    l.chomp.split(" -> ")
  end
end

def coordinate(str)
  str.split(",").map(&:to_i)
end

def printmap(m)
  m.each do |elem|
    print "." if elem.nil?
    unless elem.nil?
      elem.each do |i|
        print i unless i.nil?
        print "." if i.nil?
        print ","
      end
    end
    print "\n"
  end
end

def draw_horizontal_or_vertical(map, start, fin)
  min_x, max_x = [start.first, fin.first].minmax
  min_y, max_y = [start.last, fin.last].minmax
  (min_x..max_x).each do |x|
    (min_y..max_y).each do |y|
      map[y] = [] if map[y].nil?
      map[y][x] += 1 unless map[y][x].nil?
      map[y][x] = 1 if map[y][x].nil?
    end
  end
end

def draw_diagonal(map, start, fin)
  x = start.first
  y = start.last

  length_x = fin[0] - start[0]
  length_y = fin[1] - start[1]

  steps = [length_x.abs, length_y.abs].max + 1

  increment_x, increment_y = 1, 1
  increment_x = -1 if length_x < 0
  increment_y = -1 if length_y < 0

  steps.times do |n|
    map[y] = [] if map[y].nil?
    map[y][x] += 1 unless map[y][x].nil?
    map[y][x] = 1 if map[y][x].nil?
    x += increment_x
    y += increment_y
  end
end

def a
  map = Array.new()
  input.each do |elem|
    one = coordinate(elem.first)
    two = coordinate(elem.last)
    if one.first == two.first || one.last == two.last
      draw_horizontal_or_vertical(map, one, two)
    end
  end

  result = map.reject(&:nil?).sum do |x|
    x.reject(&:nil?).count { |elem| elem > 1 }
  end

  puts result
end

def b
  map = Array.new()
  input.each do |elem|
    one = coordinate(elem.first)
    two = coordinate(elem.last)
    if one.first == two.first || one.last == two.last
      draw_horizontal_or_vertical(map, one, two)
    else
      draw_diagonal(map, one, two)
    end
  end

  result = map.reject(&:nil?).sum do |x|
    x.reject(&:nil?).count { |elem| elem > 1 }
  end

  puts result
end

a
b
