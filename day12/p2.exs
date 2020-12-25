defmodule AOC do
  def input(f) do
    File.read!(f)
    |> String.split("\n", trim: true)
    |> process_directions
  end

  def split_direction(direction) do
    String.split(direction,
      ~r/[[:alpha:]]/,
      include_captures: true,
      trim: true
    )
  end

  def calculate_delta(current_map, dir, steps) when dir == "W" do
    Map.put(current_map, :e, current_map[:e] - steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "E" do
    Map.put(current_map, :e, current_map[:e] + steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "N" do
    Map.put(current_map, :n, current_map[:n] + steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "S" do
    Map.put(current_map, :n, current_map[:n] - steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "R" or dir == "L" do
    turn(dir, steps, current_map)
  end

  def calculate_delta(current_map, dir, steps) when dir == "F" do
    go_e = (current_map[:e] * steps) + current_map[:absolute_e]
    go_n = (current_map[:n] * steps) + current_map[:absolute_n]
    Map.merge(current_map, %{absolute_e: go_e, absolute_n: go_n})
  end

  def turn("L", 90, state) do
    Map.merge(state, %{n: state.e ,e: -state.n})
  end
  def turn("R", 90, state) do
    Map.merge(state, %{n: -state.e ,e: state.n})
  end

  def turn("L", 270, state) do turn("R", 90, state) end
  def turn("R", 270, state) do turn("L", 90, state) end
  def turn(d, 180, state) when d in ["L", "R"] do
    Map.merge(state, %{e: -state.e, n: -state.n})
  end


  def process_directions(directions) do
    start = %{n: 1, e: 10, absolute_e: 0, absolute_n: 0}
    Enum.reduce(directions, start,
      fn x, acc ->
        [dir, steps] = split_direction(x)
        IO.puts("_______")
        IO.inspect(x)

        y = calculate_delta(acc, dir, String.to_integer(steps))
        IO.inspect(y)
        y
      end
    )
  end
end


ExUnit.start
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "in" do
    input("input.txt.orig")
    |> IO.inspect
  end
end
