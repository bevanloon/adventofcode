defmodule AOC do
  def input(f) do
    File.read!(f)
    |> String.split("\n", trim: true)
    |> Enum.at(1)
    |> String.split(",", trim: true)
    |> Enum.with_index
    |> Enum.filter(fn {v, _} -> v != "x" end)
    |> Enum.map(fn {v, i} -> {String.to_integer(v), i} end)
    |> time_busses
  end

  def time_busses(busses) do
    Enum.reduce(busses, {1, 1},
      fn {bus_id, index}, {time, step} ->
        next_time = find_next_time(bus_id, index, time, step)
        next_step = step * bus_id
        IO.puts("---")
        IO.inspect("Bus id: #{bus_id}")
        IO.inspect("Next time: #{next_time}")
        IO.inspect("Next step: #{next_step}")
        {next_time, next_step}
      end
    )
  end


  def find_next_time(bus_id, index, time, step) do
    remainder = rem(time + index, bus_id)
    cond do
      remainder == 0 ->
        time
      true ->
        find_next_time(bus_id, index, time + step, step)
    end
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
