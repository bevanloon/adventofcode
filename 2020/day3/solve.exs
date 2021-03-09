# 31 points
defmodule AOC do
  def input do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x -> String.graphemes(x) end)
    |> Enum.with_index
    |> Enum.filter(&is_tree?/1)
    |> Enum.count
    |> IO.puts
  end
  def is_tree?({row_of_snow, row_number}) when row_number <= 10 do
    # every frame going down the hill is 3 to the right, 1 down
    # so for each row, we increment the index by 3
    # This is equivalent to row_number * 3
    Enum.at(row_of_snow, row_number * 3) == "#"
  end
  def is_tree?({row_of_snow, row_number}) when row_number > 10 do
    # every frame going down the hill is 3 to the right, 1 down
    # so for each row, we increment the index by 3
    # This is equivalent to row_number * 3
    #Enum.at(row_of_snow, row_number * 3) == "#"
    Enum.at(row_of_snow, rem(row_number * 3, 31)) == "#"
  end

end

AOC.input
