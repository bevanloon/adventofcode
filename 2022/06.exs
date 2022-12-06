defmodule PacketMarker do
  def get_input() do
    File.read!("input/day06.txt")
    |> String.trim
    |> String.to_charlist
  end

  def solve(chunk) do
    get_input()
    |> Enum.chunk_every(chunk, 1)
    |> Enum.with_index(fn el, index ->
      cond do
        Enum.uniq(el) |> Enum.count == chunk -> index
        true -> nil
      end
    end)
    |> Enum.reject(fn x -> x == nil end)
    |> hd
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
