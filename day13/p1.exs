defmodule AOC do
  def input(f) do
    File.read!(f)
    |> String.split("\n", trim: true)
    |> time_busses
  end

  def time_busses([earliest_departure | tail]) do
    busses = String.split(hd(tail), ",", trim: true)
             |> Enum.filter(fn x -> x != "x" end)
             |> Enum.map(fn x -> String.to_integer(x) end)
    find_earliest_time(earliest_departure, busses)
    |> multiply
  end

  def multiply({bus_id, num_mins}) do
    bus_id * num_mins
  end

  def find_earliest_time(ed, busses) do
    time = String.to_integer(ed)
    # IO.puts(time)
    Enum.reduce(busses, %{},
      fn x, acc ->
        remainder = rem(time, x)
        Map.merge(acc, %{x => x - remainder})
      end
    )
    |> Enum.sort(
      fn ({_k, v1},{_k2, v2}) ->
        v1 <= v2
      end
    )
    |> Enum.fetch!(0)
  end
end

ExUnit.start
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "it runs" do
    input("input.txt")
    |> IO.inspect
  end
end
