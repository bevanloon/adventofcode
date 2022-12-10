defmodule Trees do
  def get_input() do
    File.read!("input/day08.txt")
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn x -> String.codepoints(x) end)
  end

  def part2() do
    forest = get_input()
    rows = forest |> Enum.count()
    cols = forest |> Enum.fetch!(1) |> Enum.count()
    0..rows - 1 |> Enum.reduce(0, fn row, greatest_area ->
      current_row = forest |> Enum.at(row)
      0..cols - 1 |> Enum.reduce(greatest_area, fn col, greatest_area ->
        current_tree = current_row |> Enum.at(col)
        area = tree_area(row, col, current_tree, forest, rows, cols)
        if area > greatest_area do
          area
        else
          greatest_area
        end
      end)
    end)
  end
  def tree_area(0, _, _, _, _, _), do: 0
  def tree_area(_, 0, _, _, _, _), do: 0
  def tree_area(row, _, _, _, total_rows, _) when row == total_rows - 1, do: 0
  def tree_area(_, cols, _, _, _, total_cols) when cols == total_cols - 1, do: 0
  def tree_area(row, col, current_tree, forest, total_rows, total_cols) do
    right = col + 1..total_cols - 1 |> Enum.reduce_while(0, fn x, count ->
      next_tree = Enum.at(forest, row) |> Enum.at(x)
      if next_tree >= current_tree do
        {:halt, count + 1}
      else
        {:cont, count + 1}
      end
    end)

    left = col - 1..0 |> Enum.reduce_while(0, fn x, count ->
      next_tree = Enum.at(forest, row) |> Enum.at(x)
      if next_tree >= current_tree do
        {:halt, count + 1}
      else
        {:cont, count + 1}
      end
    end)

    bottom = row + 1..total_rows - 1 |> Enum.reduce_while(0, fn x, count ->
      next_tree = Enum.at(forest, x) |> Enum.at(col)
      if next_tree >= current_tree do
        {:halt, count + 1}
      else
        {:cont, count + 1}
      end
    end)

    top = row - 1..0 |> Enum.reduce_while(0, fn x, count ->
      next_tree = Enum.at(forest, x) |> Enum.at(col)
      if next_tree >= current_tree do
        {:halt, count + 1}
      else
        {:cont, count + 1}
      end
    end)

    IO.puts("row: #{row}, col: #{col}, current_tree_height: #{current_tree} ")
    IO.puts("left: #{left}, right: #{right}, top: #{top}, bottom: #{bottom}")
    IO.puts(left * right * top * bottom)
    IO.puts("")
    left * right * top * bottom
  end

  def part1() do
    forest = get_input()
    rows = forest |> Enum.count()
    cols = forest |> Enum.fetch!(1) |> Enum.count()
    0..rows - 1 |> Enum.reduce(0, fn row, count ->
      current_row = forest |> Enum.at(row)
      0..cols - 1 |> Enum.reduce(count, fn col, counter ->
        current_tree = current_row |> Enum.at(col)
        v = visible_tree?(row, col, current_tree, forest, rows, cols)
        if v do
          counter + 1
        else
          counter
        end
      end)
    end)
  end

  def visible_tree?(0, _, _, _, _, _), do: true
  def visible_tree?(_, 0, _, _, _, _), do: true
  def visible_tree?(row, _, _, _, total_rows, _) when row == total_rows - 1, do: true
  def visible_tree?(_, cols, _, _, _, total_cols) when cols == total_cols - 1, do: true

  def visible_tree?(row, col, current_tree, forest, total_rows, total_cols) do
    blocked_right = col + 1..total_cols - 1 |> Enum.reduce(false, fn x, taller ->
      next_tree = Enum.at(forest, row) |> Enum.at(x)
      taller || next_tree >= current_tree
    end)
    blocked_left = 0..col - 1 |> Enum.reduce(false, fn x, taller ->
      next_tree = Enum.at(forest, row) |> Enum.at(x)
      taller || next_tree >= current_tree
    end)

    blocked_top = row + 1..total_rows - 1 |> Enum.reduce(false, fn x, taller ->
      next_tree = Enum.at(forest, x) |> Enum.at(col)
      taller || next_tree >= current_tree
    end)
    blocked_bottom = 0..row - 1 |> Enum.reduce(false, fn x, taller ->
      next_tree = Enum.at(forest, x) |> Enum.at(col)
      taller || next_tree >= current_tree
    end)

    !blocked_top || !blocked_bottom || !blocked_right || !blocked_left
  end
end

IO.inspect(Trees.part1())
IO.inspect(Trees.part2())
