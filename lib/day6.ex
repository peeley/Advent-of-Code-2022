defmodule Advent2022.Day6 do
  def input do
    {:ok, data} = File.read("resources/day6.txt")

    data
  end

  def part1 do
    {_, ans} = input()
    |> String.split("", trim: true)
    |> Enum.chunk_every(4, 1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.with_index()
    |> Enum.filter(fn {char_freqs, _idx} ->
      Enum.all?(char_freqs, fn {_char, freq} -> freq == 1 end)
    end)
    |> List.first

    # since the first group is technically four chars in
    ans + 4
  end
end
