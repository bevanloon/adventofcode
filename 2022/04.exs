defmodule Clean do
  def get_input() do
    File.read!("input/day04.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&create_integer_lists(&1))
  end

  def create_integer_lists([left, right]) do
    [hyphenated_strings_to_int_list(left), hyphenated_strings_to_int_list(right)]
  end

  def hyphenated_strings_to_int_list(pair) do
    String.split(pair, "-")
    |> Enum.map(&String.to_integer(&1))
  end

  def fully_contained?([l, r]) when hd(l) <= hd(r) and tl(l) >= tl(r), do: true
  def fully_contained?([l, r]) when hd(r) <= hd(l) and tl(r) >= tl(l), do: true
  def fully_contained?([_, _]), do: false

  def part_1() do
    get_input()
    |> Enum.filter(fn x -> fully_contained?(x) end)
    |> Enum.count
  end

  def partially_contained?([[a,b],[c,d]]) when a <= d and b >= c, do: true
  def partially_contained?([[a,b],[c,d]]) when c <= b and d >= a, do: true
  def partially_contained?([_,_]), do: false

  def part_2() do
    get_input()
    |> Enum.filter(fn x -> partially_contained?(x) end)
    |> Enum.count
  end
end

IO.inspect(Clean.part_1())
IO.inspect(Clean.part_2())
