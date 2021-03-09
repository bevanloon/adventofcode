defmodule AOC do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction(&1))
    |> List.to_tuple
    |> replace_and_run
    |> Enum.reject(fn x -> x == nil end)
  end

  def parse_instruction(instruction) do
    instruction_list = String.split(instruction, " ")
    [List.first(instruction_list), String.to_integer(List.last(instruction_list))]
  end

  def replace_and_run(instructions) do
    range = 0..tuple_size(instructions) - 1
    for i <- range do
      instruction = elem(instructions, i)

      cond do
        hd(instruction) == "jmp" ->
          # swap it out and run
          swap = ["nop", hd(tl(instruction))]
          test_list = put_elem(instructions, i, swap)
          run(test_list, 0, 0, MapSet.new())
        hd(instruction) == "nop" ->
          # swap it out and run
          swap = ["jmp", hd(tl(instruction))]
          test_list = put_elem(instructions, i, swap)
          run(test_list, 0, 0, MapSet.new())
        true ->
          # no op
          nil
      end

      # run the thing and note the result
    end
  end
  def run(instructions, position, acc, visited) do
    if position >= tuple_size(instructions) do
      acc
    else
      instruction = elem(instructions, position)
      cond do
        MapSet.member?(visited, position) ->
          nil #[acc, position]
        hd(instruction) == "acc" ->
          acc = acc + hd(tl(instruction))
          next_instruction = position + 1
          run(instructions, next_instruction, acc, MapSet.put(visited, position))
        hd(instruction) == "jmp" ->
          next_instruction = position + hd(tl(instruction))
          run(instructions, next_instruction, acc, MapSet.put(visited, position))
        hd(instruction) == "nop" ->
          next_instruction = position + 1
          run(instructions, next_instruction, acc, MapSet.put(visited, position))
        true ->
          "error of some sort"
      end
     end

  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC

  test "input" do
    input("input.txt")
    |> IO.inspect
  end
end

