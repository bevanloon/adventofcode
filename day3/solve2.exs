# 31 points, n steps
defmodule AOC do
  def input(step, row_step \\ 1) do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x -> String.graphemes(x) end)
    |> Enum.take_every(row_step)
    |> Enum.with_index
    |> Enum.filter(&is_tree?(&1, step))
    |> Enum.count
    |> IO.inspect
  end
  def is_tree?({row_of_snow, row_number}, step) when row_number <= div(30, step) do
    # every frame going down the hill is 3 to the right, 1 down
    # so for each row, we increment the index by 3
    # This is equivalent to row_number * 3
    Enum.at(row_of_snow, row_number * step) == "#"
  end
  def is_tree?({row_of_snow, row_number}, step) when row_number > div(30, step) do
    # every frame going down the hill is 3 to the right, 1 down
    # so for each row, we increment the index by 3
    # This is equivalent to row_number * 3
    #Enum.at(row_of_snow, row_number * 3) == "#"
    Enum.at(row_of_snow, rem(row_number * step, 31)) == "#"
  end

end
IO.puts(AOC.input(1) * AOC.input(3) * AOC.input(5) * AOC.input(7) * AOC.input(1, 2))
