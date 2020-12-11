defmodule AOC do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&split_rows_cols(&1))
    |> Enum.map(fn x ->
      %{:row_num => find_position(0, 127, x[:rows]), :col_num => find_position(0, 7, x[:cols])}
    end
    )
    |> Enum.map(fn x -> (x[:row_num] * 8) + x[:col_num] end)
    |> Enum.sort
    # |> find_seat_id
    |> IO.inspect
  end

  def find_seat_id(ids) do
    lo_index = hd(ids)
    Enum.with_index(ids, lo_index)
    # |> Enum.reject(fn {k, v} -> k == v end)
    # |> Enum.at(0)
    # |> elem(1)
  end

  def find_position(lo, hi, seats) do
    cond do
      lo == hi ->
        lo
      true ->
        [head | tail] = seats
        # work out next lo or hi
        mid = lo + div(hi + 1 - lo, 2)
        if head == "F" or head == "L" do
          find_position(lo, mid - 1, tail)
        else
          find_position(mid, hi, tail)
        end
    end
  end

  def split_rows_cols(seat) do
    rows = String.graphemes(String.slice(seat, 0, String.length(seat) - 3))
    cols = String.graphemes(String.slice(seat, String.length(seat) - 3, 3))
    %{:rows=>rows, :cols=>cols}
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "it opens the file" do
    input("input.txt")
  end

  test "it finds the position" do
    data = String.graphemes("FBFBBFF")
    assert find_position(0, 127, data) == 44
  end

  test "it splits rows and cols" do
    data = "BFFFBBFRRR"
    assert split_rows_cols(data) == %{:rows=>["B", "F", "F", "F", "B", "B", "F"], :cols=>["R", "R", "R"]}
  end
end
