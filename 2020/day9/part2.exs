defmodule AOC do
  def parse_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> run
  end

  def run(in_list) do
    res = gogo_adder(in_list, [], 0, 50047984)
    cond do
      res != nil ->
        Enum.min_max(res)
        |> Tuple.to_list
        |> Enum.sum
      res == nil ->
        [_h | t] = in_list
        run(t)
    end
  end


  def gogo_adder([_head | _tail], collected, acc, target) when acc == target do
    collected
  end

  def gogo_adder([_head | _tail], _collected, acc, target) when acc > target do
    nil
  end

  def gogo_adder([_head | tail], _collected, _acc, _target) when tail == [] do
    nil
  end

  def gogo_adder([head | tail], collected, acc, target) do
    gogo_adder(tail, [head | collected], acc + head, target)
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
