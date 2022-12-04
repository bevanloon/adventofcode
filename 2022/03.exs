defmodule Backpack do
  def get_input do
    File.read!("input/day03.txt")
    |> String.trim
    |> String.split
  end

  def part_1 do
    get_input()
    |> Enum.map(&items_in_both_compartments(&1))
    |> Enum.map(&score(&1))
    |> Enum.sum
  end

  def part_2 do
    get_input()
    |> Enum.chunk_every(3)
    |> Enum.map(&intersection_of(&1))
    |> Enum.map(&score(&1))
    |> Enum.sum
  end

  def intersection_of([a, b, c]) do
    into_mapset(a)
    |> MapSet.intersection(into_mapset(b))
    |> MapSet.intersection(into_mapset(c))
    |> MapSet.to_list
    |> hd
  end

  def into_mapset(item) do
    item |> String.graphemes |> Enum.into(MapSet.new)
  end

  def items_in_both_compartments(string) do
    # Enum.find returns 1st element matching the condition
    {left, right} = String.split_at(string, div(String.length(string), 2))
    String.graphemes(left)
    |> Enum.find(&String.contains?(right, &1))
  end

  # a - z = 1 to 26
  # A - Z = 27 to 52
  # Elixir - ?a == 97 and ?A == 65
  def score(item) do
    code = item |> to_charlist |> hd
    cond do
      String.upcase(item) != item -> code - 96
      true -> code - 38
    end
  end
end

IO.inspect(Backpack.part_1)
IO.inspect(Backpack.part_2)
{time, result} = :timer.tc(&Backpack.part_2/0)
IO.puts("")
IO.puts(time)
IO.puts(result)
