defmodule Advent2022.Day1 do
  def part1 do
    calories_per_elf()
    |> Enum.max()
  end

  def calories_per_elf do
    {:ok, data} = File.read("resources/day1.txt")

    String.split(data, "\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&(parse_and_sum_group(&1)))
  end

  def parse_and_sum_group(list_of_calories) do
    Enum.reduce(list_of_calories, 0, fn elem, acc ->
      {num, _} = Integer.parse(elem)
      num + acc
    end)
  end

  def part2 do
    calories_per_elf()
    |> Enum.sort
    |> Enum.take(-3)
    |> Enum.sum
  end
end
