sample_input = <<HEREDOC
2199943210
3987894921
9856789892
8767896789
9899965678
HEREDOC

def input
  File.read("input.txt")
end

Point = Struct.new(:x, :y, :val) do
  def is_min_adjacent?(all_points)
    left = all_points.find { |point| point.x == x - 1 && point.y == y }
    up = all_points.find { |point| point.x == x && point.y == y - 1 }
    right = all_points.find { |point| point.x == x + 1 && point.y == y }
    down = all_points.find { |point| point.x == x && point.y == y + 1 }

    # if we are at the top, bottom, left or right of the grid,
    # we'll have a nil. Thus compact to get rid of the nils
    min_surrounding_value = [left, right, up, down].compact.map(&:val).min
    val < min_surrounding_value
  end

  def risk_level
    val + 1
  end
end

def create_tubes(data)
  lava_tubes = []
  data.lines.map(&:chomp).each_with_index do |line, line_idx|
    line.split("").each_with_index do |point, index|
      lava_tubes << Point.new(index, line_idx, point.to_i)
    end
  end
  lava_tubes
end

def lowest_points(lava_tube_points)
  lava_tube_points.select do |point|
    point.is_min_adjacent?(lava_tube_points)
  end
end

def sum_risk_levels(points)
  points.inject(0) do |acc, point|
    acc + point.risk_level
  end
end

tubes = create_tubes(input)
lows =  lowest_points(tubes)
sum = sum_risk_levels(lows)
p sum

