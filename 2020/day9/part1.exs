defmodule AOC do
  def parse_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(26, 1, :discard)
    |> test_chunks
    |> Enum.reject(fn x -> x == nil end)
  end

  def test_chunks(chunks) do
    Enum.map(chunks,
      fn x ->
        [head | tail] = Enum.reverse(x)
        res = any_sum?(tail, head, [])
        cond do
          res -> nil
          !res -> head
        end
      end
    )
  end


  def any_sum?([_head | tail], _desired_sum, results) when length(tail) <= 0 do
    Enum.count(results) > 0
  end

  def any_sum?([head | tail], desired_sum, results) do
    result = Enum.filter(tail, fn x ->  head + x == desired_sum end)
    any_sum?(tail, desired_sum, results ++ result)
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "it chunks" do
    parse_input("input.txt")
    |> IO.inspect
  end

  # test "any sum" do
  #   any_sum?([127, 182, 150, 117, 102], 219, [])
  #   |> IO.inspect
  # end
  # test "any_sum?" do
  #   any_sum?([25, 20, 15, 25, 47], 40, [])
  #   |> IO.inspect
  # end
end
