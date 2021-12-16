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

class LavaTubes
  attr_reader :data, :row_count, :col_count
  attr_accessor :lava_tubes

  def initialize(data)
    @data = data.lines.map(&:chomp)
    @row_count = @data.first.length
    @col_count = @data.count
    @lava_tubes = create_map
  end

  def create_map
    # 2D array which will be indexed as [y][x]
    data.collect do |line|
      line.split("").map(&:to_i)
    end
  end

  def find_lowest_points
    lowest_points = []
    lava_tubes.each_with_index do |row, col_idx|
      row.each_with_index do |point, row_idx|
        left, right, up, down = nil, nil, nil, nil

        left = lava_tubes[col_idx][row_idx - 1] if row_idx > 0
        right = lava_tubes[col_idx][row_idx + 1] if row_idx < row_count - 1
        up = lava_tubes[col_idx - 1][row_idx] if col_idx > 0
        down = lava_tubes[col_idx + 1][row_idx] if col_idx < col_count - 1

        if point < [left, right, up, down].compact.min
          lowest_points << [col_idx, row_idx]
        end
      end
    end
    lowest_points
  end

  def tally_lowest_points
    find_lowest_points.inject(0) do |acc, point|
      acc + lava_tubes[point.first][point.last] + 1
    end
  end

  def get_surrounding_coordinates(x, y)
    left_coord, right_coord, up_coord, down_coord = nil, nil, nil, nil
    left_coord = [y, x - 1] if x > 0
    right_coord = [y, x + 1] if x < row_count - 1
    up_coord= [y - 1, x] if y > 0
    down_coord = [y + 1, x] if y < col_count - 1
    return left_coord, right_coord, up_coord, down_coord
  end

  def get_point_value(coord, current_point_value)
    value = lava_tubes[coord.first][coord.last]
    return value if value > current_point_value && value < 9
    return nil
  end

  def get_surrounding_points(left_coord, right_coord, up_coord, down_coord, current_point)
    left, right, up, down = nil, nil, nil, nil

    left = get_point_value(left_coord, current_point) if left_coord
    right = get_point_value(right_coord, current_point) if right_coord
    up = get_point_value(up_coord, current_point) if up_coord
    down = get_point_value(down_coord, current_point) if down_coord
    return left, right, up, down
  end

  def find_basins
    caves = []
    basins = []
    find_lowest_points.each do |point|
      visited = []
      size = 0
      caves << point

      while caves.length != 0 do
        next_point = caves.shift
        next if visited.include?(next_point)

        visited << next_point
        size += 1
        next_point_value = lava_tubes[next_point.first][next_point.last]

        # get surrounding point co-ordinates
        left_coord, right_coord, up_coord, down_coord = get_surrounding_coordinates(next_point.last, next_point.first)

        # get surrounding points
        left, right, up, down = get_surrounding_points(left_coord, right_coord, up_coord, down_coord, next_point_value)

        caves << left_coord if left
        caves << right_coord if right
        caves << up_coord if up
        caves << down_coord if down
      end

      basins.append(size)
    end
    basins.sort!.reverse!
    basins[0] * basins[1] * basins[2]
  end
end

t = LavaTubes.new(input)
puts "Part 1: #{t.tally_lowest_points}"
puts "Part 2: #{t.find_basins}"


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

# tubes = create_tubes(input)
# lows =  lowest_points(tubes)
# sum = sum_risk_levels(lows)
# p sum
