input = <<HEREDOC
8577245547
1654333653
5365633785
1333243226
4272385165
5688328432
3175634254
6775142227
6152721415
2678227325
HEREDOC

sample = <<HEREDOC
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
HEREDOC

class Dumbo
  attr_accessor :flashes

  def initialize
    @flashes = 0
  end

  def create_grid(input)
    input.lines.collect do |line|
      line.chomp.split("").map(&:to_i)
    end
  end

  def adjacent(y, x)
    adj = []

    adj << [y, x + 1] if x < 9
    adj << [y, x - 1] if x > 0
    adj << [y + 1, x] if y < 9
    adj << [y - 1, x] if y > 0
    adj << [y - 1, x - 1] if x > 0 && y > 0
    adj << [y - 1, x + 1] if x < 9 && y > 0
    adj << [y + 1, x - 1] if x > 0 && y < 9
    adj << [y + 1, x + 1] if x < 9 && y < 9

    adj
  end

  def step(data)
    over_nines = []
    (0..9).each do |y|
      (0..9).each do |x|
        data[y][x] += 1
        over_nines << [y, x] if data[y][x] == 10
      end
    end

    # puts
    # puts "---"
    # p over_nines
    # puts

    while over_nines.length > 0
      # work out adjacent
      # add 1 to adjacent
      # if adjacent is now 9, add to flash
      next_nine = over_nines.shift
      nearby = adjacent(next_nine[0], next_nine[1])
      nearby.each do |item|
        y, x = item[0], item[1]
        data[y][x] += 1
        over_nines << [y, x] if data[y][x] == 10
      end
    end

    old = @flashes
    (0..9).each do |y|
      (0..9).each do |x|
        if data[y][x] > 9
          data[y][x] = 0

          @flashes += 1
        end
      end
    end

    data
  end

  def output(grid)
    grid.each do |row|
      p row
    end
  end
end

octo = Dumbo.new
grid = octo.create_grid(input)
endo = (0..250).inject(grid) do |acc_grid, idx|
  before_flash = octo.flashes

  a_grid = octo.step(acc_grid)

  if octo.flashes - before_flash == 100
    puts "Part 2 - all flash first at : #{idx + 1}"
  end

  a_grid
end
puts "Part 1: #{octo.flashes}"
