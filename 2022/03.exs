defmodule Backpack do
  def part_1 do
    File.read!("input/day03.txt")
    |> String.trim
    |> String.split
    |> solve
  end

  def part_2 do
    File.read!("input/day03.txt")
    |> String.trim
    |> String.split
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> intersection_of(x) end)
    |> Enum.map(fn x ->
        codepoint = hd(to_charlist(x))
        cond do
          String.upcase(x) != x -> codepoint - 96
          true -> codepoint - 38
        end
    end)
    |> Enum.sum
  end

  def intersection_of(three) do
    a = three |> Enum.at(0) |> String.graphemes |> Enum.into(MapSet.new)
    b = three |> Enum.at(1) |> String.graphemes |> Enum.into(MapSet.new)
    c = three |> Enum.at(2) |> String.graphemes |> Enum.into(MapSet.new)
    a
    |> MapSet.intersection(b)
    |> MapSet.intersection(c)
    |> MapSet.to_list
    |> hd
  end

  # a - z = 1 to 26
  # A - Z = 27 to 52
  # Elixir - ?a == 97 and ?A == 65
  def solve(backpacks) do
    backpacks
    |> Enum.map(&items_in_both_compartments(&1))
    |> Enum.map(fn x ->
        codepoint = hd(to_charlist(x))
        cond do
          String.upcase(x) != x -> codepoint - 96
          true -> codepoint - 38
        end
    end)
    |> Enum.sum
  end

  def items_in_both_compartments(string) do
    # Enum.find returns 1st element matching the condition
    {left, right} = String.split_at(string, div(String.length(string), 2))
    String.graphemes(left)
    |> Enum.find(&String.contains?(right, &1))
  end
end

IO.inspect(Backpack.part_1)
IO.inspect(Backpack.part_2)
