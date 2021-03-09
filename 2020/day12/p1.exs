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

  def next_north(i) do
    Enum.fetch!([:e, :s, :w], i)
  end
  def next_south(i) do
    Enum.fetch!([:w, :n, :e], i)
  end
  def next_east(i) do
    Enum.fetch!([:s, :w, :n], i)
  end
  def next_west(i) do
    Enum.fetch!([:n, :e, :s], i)
  end
  def calculate_index(dir, steps) do
    cond do
      dir == "R" ->
        div(steps, 90) - 1
      dir == "L" ->
        div(steps, 90) * -1
    end
  end

  def calculate_delta(current_map, dir, steps) when dir == "W" or dir == :w do
    Map.put(current_map, :e, current_map[:e] - steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "E" or dir == :e do
    Map.put(current_map, :e, current_map[:e] + steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "N" or dir == :n do
    Map.put(current_map, :n, current_map[:n] + steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "S" or dir == :s do
    Map.put(current_map, :n, current_map[:n] - steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "F" do
    facing = current_map[:cur_dir]
    calculate_delta(current_map, facing, steps)
  end

  def calculate_delta(current_map, dir, steps) when dir == "R" or dir == "L" do
    index = calculate_index(dir, steps)
    facing = current_map[:cur_dir]
    cond do
      facing == :n ->
        Map.put(current_map, :cur_dir, next_north(index))
      facing == :s ->
        Map.put(current_map, :cur_dir, next_south(index))
      facing == :w ->
        Map.put(current_map, :cur_dir, next_west(index))
      facing == :e ->
        Map.put(current_map, :cur_dir, next_east(index))
    end
  end

  def process_directions(directions) do
    start = %{cur_dir: :e, n: 0, e: 0}
    Enum.reduce(directions, start,
      fn x, acc ->
        [dir, steps] = split_direction(x)
        calculate_delta(acc, dir, String.to_integer(steps))
      end
    )
  end
end


ExUnit.start
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "in" do
    input("input.txt")
    |> IO.inspect
  end
end
