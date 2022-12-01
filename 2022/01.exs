defmodule Day01 do
  def get_input(part1_or_2) do
    File.read!("input/day01.txt")
    |> String.trim
    |> String.split("\n\n")
    |> Enum.map(&elf_calories(&1))
    |> part1_or_2.()
  end

  def elf_calories(str) do
    String.split(str, "\n")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum
  end

  def part1(enum) do
    enum
    |> Enum.max
  end

  def part2(enum) do
    enum
    |> Enum.sort
    |> Enum.take(-3)
    |> Enum.sum
  end
end

IO.inspect(Day01.get_input(&Day01.part1/1))
IO.inspect(Day01.get_input(&Day01.part2/1))
