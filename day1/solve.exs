defmodule AOC do
  def get_input do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def part1 do
    input = AOC.get_input

    for x <- input,
        y <- input,
        x + y == 2020 do
      x * y
    end
  end

  def part2 do
    input = AOC.get_input

    for x <- input,
        y <- input,
        z <- input,
        x + y + z == 2020 do
      x * y * z
    end
  end
end

IO.inspect(AOC.part1)
IO.inspect(AOC.part2)
