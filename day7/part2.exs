defmodule Luggage do
  defstruct [:bag, :contents]

  def input(filename) do
    File.read!(filename)
    |> singular
    |> String.split(["\n", "."], trim: true)
    |> Enum.map(&String.split(&1, [" contain ", ",", ","], trim: true))
    |> Enum.map(&parse/1)
    |> find_and_count_children("shiny gold bag", 0, 1)
  end

  def find_first_level(luggage, needle, acc) do
    next_bags = Enum.filter(luggage, fn [_bag | contents] ->
      search_contents(needle, hd(contents)) end)
      |> Enum.map(fn x -> hd(x) end)
    if next_bags == [] do
      acc
    else
      acc = acc ++ next_bags
      Enum.map(next_bags, fn x -> find_first_level(luggage, x, acc) end)
    end
  end


  def find_and_count_children(luggage, needle_parent, acc, multiplier) do
    parent_bag = Enum.find(luggage, fn [outer_bag | _contents] -> outer_bag == needle_parent end)
    # count number bags the parent bag contains
    number_bags_in_parent = List.last(parent_bag)
                            |> Enum.reduce(0, fn [hd | _tl], count  -> count + hd end)

    acc = acc + (number_bags_in_parent * multiplier)

    # now for each child bag, find the children
    child_bags = List.last(parent_bag)
                 # |> Enum.map(fn [_hd | tl] -> hd(tl) end)

    if child_bags == [[0, "stop"]] do
      acc
    else
      # map through the child bags and add 'em in
      Enum.reduce(child_bags, acc, fn x, acc ->
        multiply_by = hd(x) * multiplier
        bag_name_to_find = hd(tl(x))
        find_and_count_children(luggage, bag_name_to_find, acc, multiply_by)
      end)
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
    Enum.map(bags, fn x ->
      String.split(x, " ", parts: 2, trim: true)
      |> baggy
    end)
  end

  def baggy(bag) when hd(bag) != "no" do
    [String.to_integer(List.first(bag)), List.last(bag)]
  end

  def baggy(bag) when hd(bag) == "no" do
    [0, "stop"]
  end

  def singular(bags) do
    String.replace(bags, "bags", "bag")
  end
end

ExUnit.start()
defmodule LuggageTest do
  use ExUnit.Case, async: true
  import Luggage

  test "it opens the file" do
    out = input("input.txt")
    IO.inspect(out)
  end
end
