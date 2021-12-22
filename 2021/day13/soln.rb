sample = <<HEREDOC
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
HEREDOC

class GridFolder
  attr_accessor :grid_data, :fold_data, :grid

  def initialize
    @grid_data = []
    @fold_data = []
  end

  def process_input
    File.read("input.txt")
  end

  def grid_max_x
    grid[0].length
  end

  def grid_max_y
    grid.length
  end

  def init_grid
    raw_data_max_y = grid_data.collect { |x, y| y }.max
    raw_data_max_x = grid_data.collect { |x, y| x }.max
    @grid = Array.new(raw_data_max_y + 1) {|i| Array.new(raw_data_max_x + 1, ".")}
  end

  def populate_grid
    grid_data.each do |x, y|
      grid[y][x] = "█"
    end
  end

  def fold_x(index)
    new_grid = Array.new(grid_max_y) {|i| Array.new(index, "")}
    grid.each_with_index do |row, row_idx|
      left = row[0..index - 1]
      right = row[index + 1..].reverse
      left.each_with_index do |item, col_idx|
        new_grid[row_idx][col_idx] = item == "█" ? "█" : right[col_idx]
      end
    end

    @grid = new_grid
  end

  def fold_y(index)
    top = grid[0..index - 1]
    bottom = grid[index + 1..].reverse
    while bottom.length < top.length
      bottom.unshift(Array.new(grid_max_x, ""))
    end
    new_grid = Array.new(index) {|i| Array.new(grid_max_x, "") }
    top.each_with_index do |row, row_idx|
      row.each_with_index do |item, col_idx|
        new_grid[row_idx][col_idx] = item == "█" ? "█" : bottom[row_idx][col_idx]
      end
    end

    @grid = new_grid
  end

  def fold_grid
    fold_data.each do |axis_command, position|
      # get last character which gives us axis
      axis = axis_command[-1]
      index = position.to_i

      fold_y(index) if axis == "y"
      fold_x(index) if axis == "x"
    end
  end

  def input(data=process_input)
    data.lines do |line|
      grid_data << line.chomp.split(",").map(&:to_i) unless line.start_with?("fold") || line.chomp.length == 0
      fold_data << line.chomp.split("=") if line.start_with?("fold")
    end
  end

  def print_grid
    grid.each {|g| p g.join}
  end
end

fold = GridFolder.new
fold.input()
fold.init_grid
fold.populate_grid
fold.fold_grid
fold.print_grid
# dots = fold.grid.inject(0) do |acc, row|
#   acc += row.count("#")
# end
# puts "dots:"
# p dots
