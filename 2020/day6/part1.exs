defmodule AOC do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&count_languages(&1))
    |> Enum.sum
    |> IO.inspect
  end

  def count_languages(group_langs) do
    String.codepoints(group_langs)
    |> Enum.reject(fn x -> x == "\n" end)
    |> Enum.uniq
    |> Enum.count
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "it opens the file" do
    input("input.txt")
  end
end
