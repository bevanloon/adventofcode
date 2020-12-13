defmodule Luggage do
  defstruct [:bag, :contents]

  def input(filename) do
    File.read!(filename)
    |> singular
    |> String.split(["\n", "."], trim: true)
    |> Enum.map(&String.split(&1, [" contain ", ",", ","], trim: true))
    |> Enum.map(&parse/1)
    |> find_first_level("shiny gold bag", [])
  end

  def find_first_level(luggage, needle, acc) do
    next_bags = Enum.filter(luggage, fn [_bag | contents] ->
      search_contents(needle, hd(contents)) end)
      |> Enum.map(fn x -> hd(x) end)
    if next_bags == [] do
      acc
    else
      acc = acc ++ next_bags
      # IO.inspect(acc)
      # IO.puts("---")
      Enum.map(next_bags, fn x -> find_first_level(luggage, x, acc) end)
    end
  end

  def search_contents(needle, haystack) do
    Enum.find(haystack, fn [_count | bag] ->
      hd(bag) == needle
    end )
  end

  def parse([key | bags_contained]) do
    [key, parse_inner_bags(bags_contained)]
  end

  def parse_inner_bags(bags) do
    Enum.map(bags, &String.split(&1, " ", parts: 2, trim: true))
  end

  def singular(bags) do
    String.replace(bags, "bags", "bag")
  end

end

ExUnit.start()
defmodule LuggageTest do
  use ExUnit.Case, async: true
  import Luggage

  # [
  # ["wavy green bags", "1 posh black bag", " 1 faded green bag",
  #  " 4 wavy red bags."],
  # ["dotted chartreuse bags", "1 light beige bag."],
  # ["dark white bags", "2 dotted white bags."]
# ]
  # test "it parses inner bags" do
  #   data = ["1 posh black bag", " 1 faded green bag", " 4 wavy red bags."]
  #   parse_inner_bags(data)
  #   |> IO.inspect
  # end

  # test "it parses a bag" do
  #   data =["wavy green bags", "1 posh black bag", " 1 faded green bag", " 4 wavy red bags."]
  #   parse(data)
  #   |> IO.inspect
  # end
  test "it opens the file" do
    input("input.txt")
    |> List.flatten
    |> Enum.uniq
    |> Enum.count
    |> IO.inspect
  end
end
