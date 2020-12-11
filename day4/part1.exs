# A single passport might span multiple line
# However, passports are separated by a blank line
# Split first on ("\n\n") to separate out each passport
# Then for each, replace \n with a space
defmodule AOC do
  def read_in() do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&generate_map_from_str(&1))
    |> Enum.count(&valid_documents?(&1))
    |> IO.inspect
  end

  def generate_map_from_str(str) do
    String.replace(str, "\n", " ", global: true)
    |> String.split
    |> Enum.into(%{}, fn x ->
      {List.first(String.split(x, ":")), List.last(String.split(x, ":"))}
        end)
  end

  def valid_documents(document) do
    7 == Enum.count(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"],
      fn x -> Map.has_key?(document, x) end
    )
  end
end

AOC.read_in()

