# 13221
# 13131
defmodule RockPaperScissors do
  # A - Rock, B - Paper, C - Scissors
  # part 1 X - Rock, Y - Paper, Z - Scissors
  # part 2 X - lose, Y - draw, Z - win
  # Scores - X = 1, Y = 2, Z = 3
  # Scores - 0 = loss, 3 = draw, 6 = win
  def get_input() do
    File.stream!("input/day02.txt")
    |> Stream.map(&String.trim/1)
  end

  def solve(which_part) do
    get_input()
    |> Enum.reduce(0, fn x, acc -> acc + which_part.(x) end)
  end

  def part2("A X"), do: 0 + 3 # choose scissors to lose
  def part2("A Y"), do: 3 + 1 # choose rock to draw
  def part2("A Z"), do: 6 + 2 # choose paper to win
  def part2("B X"), do: 0 + 1
  def part2("B Y"), do: 3 + 2
  def part2("B Z"), do: 6 + 3
  def part2("C X"), do: 0 + 2
  def part2("C Y"), do: 3 + 3
  def part2("C Z"), do: 6 + 1

  def part1("A Y"), do: 6 + 2
  def part1("B Z"), do: 6 + 3
  def part1("C X"), do: 6 + 1
  def part1("A X"), do: 3 + 1
  def part1("B Y"), do: 3 + 2
  def part1("C Z"), do: 3 + 3
  def part1("A Z"), do: 0 + 3
  def part1("B X"), do: 0 + 1
  def part1("C Y"), do: 0 + 2
end

IO.inspect(RockPaperScissors.solve(&RockPaperScissors.part1/1))
IO.inspect(RockPaperScissors.solve(&RockPaperScissors.part2/1))
