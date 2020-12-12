defmodule AOC do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&count_languages(&1))
    |> Enum.sum
    |> IO.inspect
  end

  def count_languages(group_langs) do
    String.split(group_langs, "\n", trim: true)
    |> Enum.map(&String.graphemes(&1))
    |> find_intersection
  end

  def find_intersection(group) when length(group) > 1 do
    Enum.reduce(group, fn x, acc ->
      MapSet.intersection(MapSet.new(x), MapSet.new(acc))
    end)
    |> MapSet.size
  end

  def find_intersection(group) when length(group) ==1 do
    Enum.into(hd(group), MapSet.new)
    |> MapSet.size
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "it opens the file" do
    input("input.txt")
  end

  # test "it should find intersections" do
  #   data = [
  #     [ ["a"] ],
  #     [
  #       ["g", "q", "r", "a", "p", "l", "u"],
  #       ["j", "m", "w", "f", "t", "i", "d", "y", "n", "v", "o", "z", "k", "h", "e"]
  #     ],
  #     [
  #       ["c", "b", "h", "e", "j", "s", "p", "l", "z", "t", "n", "d", "v", "i", "g"],
  #       ["d", "u", "z", "p", "t", "e", "c", "l", "s", "h", "f", "g", "b", "i", "n",
  #         "v", "j"],
  #       ["z", "v", "b", "h", "d", "t", "n", "i", "g", "p", "l", "s", "e", "j"],
  #       ["z", "t", "s", "b", "d", "i", "x", "m", "e", "g", "l", "j", "h", "n", "v",
  #         "a", "p", "y"]
  #     ]
  #   ]
  #   Enum.map(data, fn x -> find_intersection(x) end)
  #   |> IO.inspect
  # end
end
