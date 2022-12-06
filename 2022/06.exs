defmodule PacketMarker do
  def get_input() do
    File.read!("input/day06.txt")
    |> String.trim
    |> String.to_charlist
  end

  def solve(chunk) do
    get_input()
    |> Enum.chunk_every(chunk, 1)
    |> Enum.with_index()
    |> Enum.filter(fn {el, index} -> Enum.uniq(el) |> Enum.count == chunk end)
    |> hd # tuple like {'qnvj', 1844}
    |> elem(1)
    |> Kernel.+(chunk)
  end

  def part2 do
    solve(14)
  end

  def part1 do
    solve(4)
  end
end

IO.inspect(PacketMarker.part1()) # => 1848
IO.inspect(PacketMarker.part2()) # => 1848
