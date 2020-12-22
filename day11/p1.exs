defmodule AOC do
  def input(f) do
    File.read!(f)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes(&1) |> to_num_map)
    |> to_num_map
    |> mutate_until_stable
  end

  def mutate_until_stable(seating_grid) do
    next_generation = Enum.reduce(seating_grid, %{},
      fn {row, cols}, acc ->
        new_cols = Enum.reduce(cols, %{},
          fn {col_number, seat}, acc ->
            new_seat = apply_rule(seat, adjacent_chairs(row, col_number, seating_grid))
            Map.put(acc, col_number, new_seat)
          end
        )
        Map.put(acc, row, new_cols)
      end
    )

    cond do
      next_generation == seating_grid ->
        count_occupied_seats(seating_grid)
      true ->
        mutate_until_stable(next_generation)
    end
  end

  def count_occupied_seats(seating_grid) do
    Enum.reduce(seating_grid, 0,
      fn {_row, cols}, acc ->
        occupied_cols = Enum.filter(cols,
          fn {_col_number, seat} ->
            seat == "#"
          end
        ) |> Enum.count
        acc + occupied_cols
      end
    )
  end

  def to_num_map(enum) do
    # with_index returns enumerable with index as tail
    # so we need to swap them around before sending them
    # into a map
    Enum.with_index(enum)
    |> Enum.map( fn {v, k} -> {k, v} end)
    |> Enum.into(%{})
  end

  def adjacent_chairs(row, col, chairs) do
    [
      chairs[row - 1][col - 1],
      chairs[row - 1][col],
      chairs[row - 1][col + 1],
      chairs[row + 1][col - 1],
      chairs[row + 1][col],
      chairs[row + 1][col + 1],
      chairs[row][col - 1],
      chairs[row][col + 1],
    ]
  end


  # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
  # If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
  # Otherwise, the seat's state does not change.
  def apply_rule(seat, adjacent) do
    occupied_adjacent = Enum.count(adjacent, fn x -> x == "#" end)
    cond do
      seat == "#" && occupied_adjacent >= 4 ->
        "L"
      seat == "L" && occupied_adjacent == 0 ->
        "#"
      true ->
        seat
    end
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
