defmodule AOC do
  def parse_input do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn y -> String.split(y, [":", " ", "-"], trim: true) end)
  end

  def password_validator_part1([low_string, high_string, letter, password]) do
    low = String.to_integer(low_string)
    high = String.to_integer(high_string)

    if count_elements_of(letter, password) <= high && count_elements_of(letter, password) >= low do
      :true
    else
      :false
    end
  end

  def password_validator_part2([low_string, high_string, letter, password]) do
    low_letter = String.at(password, String.to_integer(low_string) - 1)
    high_letter = String.at(password, String.to_integer(high_string) - 1)

    if Enum.count([low_letter, high_letter], fn x -> x == letter end) == 1 do
      :true
    else
      :false
    end
  end

  def count_elements_of(letter, password) do
    String.graphemes(password)
    |> Enum.count(fn x -> x == letter end)
  end

  def solve_part_1 do
    Enum.map(parse_input(), &password_validator_part1/1)
    |> Enum.count(fn x -> x == true end)
  end

  def solve_part_2 do
    Enum.map(parse_input(), &password_validator_part2/1)
    |> Enum.count(fn x -> x == true end)
  end
end

IO.inspect(AOC.solve_part_1)
IO.inspect(AOC.solve_part_2)

