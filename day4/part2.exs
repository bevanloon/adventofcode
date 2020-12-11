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

  def valid?(k, v) when k == "byr" do
    year = String.to_integer(v)
    year >= 1920 and year <= 2002
  end

  def valid?(k, v) when k == "iyr" do
    year = String.to_integer(v)
    year >= 2010 and year <= 2020
  end

  def valid?(k, v) when k == "eyr" do
    year = String.to_integer(v)
    year >= 2020 and year <= 2030
  end

  def valid?(k, v) when k == "hgt" do
    if String.ends_with?(v, "cm") or String.ends_with?(v, "in") do
      height = String.to_integer(String.slice(v, 0, String.length(v) - 2))
      if String.ends_with?(v, "cm") do
        height >=  150 and height <= 193
      else
        height >= 59 and height <= 76
      end
    else
      :false
    end
  end

  def valid?(k, v) when k == "hcl" do
    String.match?(v, ~r/\#[0-9a-f]{6}$/)
  end

  def valid?(k, v) when k == "ecl" do
    Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], v)
  end

  def valid?(k, v) when k == "pid" do
    try do
      _ = String.to_integer(v)
      String.length(v) == 9
    rescue
      ArgumentError -> :false
    end
  end

  def valid?(k, _v) when k == "cid" do
    :true
  end

  def valid_documents?(document) do
    7 == for {k, v} <- document do
      unless k == "cid" do
        valid?(k, v)
      end
    end
    |> Enum.reject(fn x -> x == nil end)
    |> Enum.count(fn x -> x == true end)
  end

  def valid_documents_part1?(document) do
    7 == Enum.count(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"],
      fn x -> Map.has_key?(document, x) end
    )
  end
end

AOC.read_in()

