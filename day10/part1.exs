defmodule AOC do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.concat([0])
    |> Enum.sort
    |> Enum.chunk_every(2, 1, :discard)
    |> count_jolts
    |> one_by_three
  end

  def one_by_three(jolts) do
    Enum.at(jolts, 0) * Enum.at(jolts, 2)
  end

  def count_jolts(chargers) do
    one_jolt = filter_and_count(chargers, 1)
    two_jolts = filter_and_count(chargers, 2)
    three_jolts = filter_and_count(chargers, 3) + 1 # for our actual device
    [one_jolt, two_jolts, three_jolts]
  end

  def filter_and_count(chargers, jolts) do
    Enum.filter(chargers, fn x ->
      Enum.at(x, 1)  - Enum.at(x, 0) == jolts end)
    |> Enum.count
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "input" do
    input("input.txt")
    |> IO.inspect
  end
end
