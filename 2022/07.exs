defmodule OS do
  def get_input() do
    File.read!("input/day07.txt")
    |> String.trim
    |> String.split("\n")
  end

  def part2() do
    total_disk_size = 70000000
    needed_for_update = 30000000
    fs = pre_process()
    used = Map.get(fs, "/") |> Enum.sum

    current_free = total_disk_size - used
    extra_needed = needed_for_update - current_free

    fs
    |> sum_directory_sizes()
    |> Enum.sort
    |> Enum.find(fn x -> x >= extra_needed end)
  end

  def part1() do
    pre_process()
    |> sum_directory_sizes()
    |> Enum.reject(fn v -> v >= 100000 end)
    |> Enum.sum()
  end

  def sum_directory_sizes(fs) do
    fs
    |> Enum.reduce([], fn {_, v}, acc ->
      acc ++ [Enum.sum(v)]
    end)
  end

  def pre_process() do
    [_, file_system] =
    get_input()
    |> Enum.reduce(["", %{"/" => []}], fn command, [current_path, filesys] ->
      prefix = command |> String.slice(0, 4)

      process_line(prefix, current_path, command, filesys)
    end)

    ordered_paths = Map.keys(file_system)
    |> Enum.reject(fn x -> x == "/" end)
    |> Enum.sort_by(fn x -> String.length(x) end, :desc)

    Enum.reduce(ordered_paths, file_system, fn path, acc ->
      one_path_up = String.split(path, ",") |> Enum.drop(-1) |> Enum.join(",")
      Map.put(acc, one_path_up, Map.get(acc, one_path_up, []) ++ Map.get(acc, path))
    end)
  end

  # take care of root - i.e. we have no current path defined yet
  # broad assumption that input starts with cd /
  def process_line("$ cd", "", command, filesys) do
    [String.slice(command, 5..-1), filesys]
  end
  # navigate up a directory
  def process_line("$ cd", current_path, "$ cd ..", filesys) do
    new_path = current_path
    |> String.split(",")
    |> Enum.drop(-1)
    |> Enum.join(",")
    [new_path, filesys]
  end
  def process_line("$ cd", current_path, command, filesys) do
    new_path = current_path <> "," <> String.slice(command, 5..-1)
    [new_path, Map.put_new(filesys, new_path, [])]
  end
  def process_line(_, current_path, command, filesys) do
    size = Regex.run(~r/^\d*/, command) |> hd
    [current_path, process_size(current_path, size, filesys)]
  end

  def process_size(_, "", filesys) do
    filesys
  end
  def process_size(current_path, size, filesys) do
    Map.put(filesys, current_path, Map.get(filesys, current_path, []) ++ [String.to_integer(size)])
  end
end

IO.inspect(OS.part1())
IO.inspect(OS.part2())
