defmodule Advent2022.Day6 do
  def input do
    {:ok, data} = File.read("resources/day6.txt")

    data
  end

  def get_idx_of_unique_group(ungrouped_chars, group_size) do
    {_, ans} = ungrouped_chars
    |> String.split("", trim: true)
    |> Enum.chunk_every(group_size, 1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.with_index()
    |> Enum.filter(fn {char_freqs, _idx} ->
      Enum.all?(char_freqs, fn {_char, freq} -> freq == 1 end)
    end)
    |> List.first

    ans + group_size
  end

  def part1 do
    input()
    |> get_idx_of_unique_group(4)
  end

  def part2 do
    input()
    |> get_idx_of_unique_group(14)
  end
end
