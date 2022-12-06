defmodule Container do
  def get_input do
    [data_stacks, data_instructions] = File.read!("input/day05.txt")
    |> String.split("\n\n")

    stacks = data_stacks
    |> String.split("\n")
    |> Enum.drop(-1) # last row contains the stack numbers - we don't need these
    |> Enum.map(&String.graphemes(&1)
                |> Enum.chunk_every(3, 4) # we create 3 item lists - either empty strings or ["[", "L", "]"]
                |> Enum.map(fn x -> Enum.at(x, 1) end) # we always want the item at index 1 the rest is just filler
                |> Enum.with_index(1)
    )
    |> Enum.flat_map(fn x -> x end)
    |> Enum.filter(fn {v, _} -> String.trim(v) != "" end)
    |> Enum.group_by(fn {_, k} -> k end, fn {v, _} -> v end)

    instructions = data_instructions
    |> String.trim()
    |> String.split("\n")

    [stacks, instructions]
  end


  def part2() do
    [stacks, instructions] = get_input()
    instructions
    |> Enum.reduce(stacks, fn instruction, acc ->
      [how_many, from, destination] = execute_instruction(instruction)
      acc = %{acc | destination => slice(acc[from], how_many) ++ acc[destination]}
      acc = %{acc | from => Enum.drop(acc[from], how_many)}
      acc
    end)
    |> Enum.map(fn {_, v} -> hd(v) end)
    |> Enum.join
  end
  def part1() do
    [stacks, instructions] = get_input()
    instructions
    |> Enum.reduce(stacks, fn instruction, acc ->
      [how_many, from, destination] = execute_instruction(instruction)
      acc = %{acc | destination => slice_and_reverse(acc[from], how_many) ++ acc[destination]}
      acc = %{acc | from => Enum.drop(acc[from], how_many)}
      acc
    end)
    |> Enum.map(fn {_, v} -> hd(v) end)
    |> Enum.join
  end

  def slice(enum, how_many) do
    Enum.slice(enum, 0, how_many)
  end

  def slice_and_reverse(enum, how_many) do
    slice(enum, how_many)
    |> Enum.reverse
  end

  def execute_instruction(instruction) do
    instruction
    |> String.split(" ")
    |> Enum.reject(fn x -> String.match?(x, ~r/[from|move|to]/) end)
    |> Enum.map(fn x -> String.to_integer(x) end)
  end
end

IO.inspect(Container.part1)
IO.inspect(Container.part2)
