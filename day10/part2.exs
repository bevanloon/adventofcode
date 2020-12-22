defmodule AOC do

  def part2data(filename) do
    data = File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)

    data = Enum.sort([0 | data], :desc)
    part2(data)
  end

  def part2(data) do
    Enum.reduce(data, %{(hd(data) + 3) => 1}, fn i, memo ->
      IO.inspect(i)
      IO.inspect(memo)
      IO.puts("---")
      Map.put(memo, i, Enum.sum(Enum.map(1..3, &Map.get(memo, i + &1, 0))))
    end)|> IO.inspect
  end



  def input(filename) do
    blah = File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.concat([0])
    |> Enum.sort
    |> Enum.reverse

    foo = combinations(blah, Enum.count(blah), %{})
    bar = Map.to_list(foo)
    |> Enum.sort
    recount(bar, [])
  end

  def recount([head | adapters], acc) when adapters == [] do
    {k, v} = head
    original = Map.merge(Enum.into(acc, %{}), Enum.into(adapters, %{}))
    up_to_index = original[k - 1]
    cond do
      v == 3 ->
        extra = original[k - 2] + original[k - 3]
        acc ++ [{k, extra + up_to_index}]
      head == 2 ->
        extra = original[k - 2]
        acc ++ [{k, extra + up_to_index}]
      true ->
        acc ++[{k, up_to_index}]
    end
  end
  def recount([head | adapters], acc) do
    {k, v} = head
    # IO.puts("-------------------------------")
    # IO.write("head ")
    # IO.inspect(head)
    # IO.write("adapters ")
    # IO.inspect(adapters)
    # IO.write("acc ")
    # IO.inspect(acc)

    original = Map.merge(Enum.into(acc, %{}), Enum.into(adapters, %{}))
    # IO.write("original ")
    # IO.inspect(original)
    up_to_index = cond do
      k > 1 ->
        original[k - 1]
      true ->
        v
    end

    cond do
      v == 3 ->
        extra = original[k - 2] + original[k - 3]

        # IO.write("v == 3, up_to_index ")
        # IO.inspect(up_to_index)
        # IO.write("v == 3, extra ")
        # IO.inspect(extra)
        recount(adapters, acc ++ [{k, extra + up_to_index}])
      v == 2 ->
        extra = original[k - 2]
        # IO.write("v == 2, up_to_index ")
        # IO.inspect(up_to_index)
        # IO.write("v == 2, extra ")
        # IO.inspect(extra)
        recount(adapters, acc ++ [{k, extra + up_to_index}])
      true ->
        # IO.write("true, up_to_index ")
        # IO.inspect(up_to_index)
        recount(adapters, acc ++ [{k, up_to_index}])
    end
  end

  def combinations([_head | adapters], count, acc) when adapters == [] do
    Map.put(acc, count, 1)
  end
  def combinations([head | adapters], count, acc) do
    num = Enum.filter(adapters,
      fn x -> head - x <= 3 end
    )
    |> Enum.count

    # acc = Map.put(acc, head => num)
    combinations(adapters, count - 1, Map.put(acc, count, num))
  end

  def find_last_two(c) do
    {last, chargers_left} = List.pop_at(c, length(c) -1)
    if chargers_left == [] do
      [last]
    else
      Enum.filter(chargers_left,
        fn x ->
          last - x <= 3
        end
      )
      |> IO.inspect(charlists: :as_lists)
      |> Enum.map(
          fn x ->
            [[last] ++ find_last_two(chargers_left) ]
          end
      )
    end
  end
end

ExUnit.start()
defmodule AOCTest do
  use ExUnit.Case, async: true
  import AOC
  test "part2" do
    part2data("input.txt.med")
  end

  # test "input" do
  #   input("input.txt")
  #   |> List.last
  #   |> IO.inspect
  # end
end
