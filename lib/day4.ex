defmodule Advent2022.Day4 do
  def input do
    {:ok, data} = File.read("resources/day4.txt")
    data
    |> String.split("\n", trim: true)
  end

  # section is a string like "1-3"
  def section_assignment_to_sections(section) do
    section
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def assignment_pairs_to_sections(assignment_pair) do
    assignment_pair
    |> String.split(",")
    |> Enum.map(&section_assignment_to_sections/1)
    |> List.to_tuple()
  end

  def section_pairs_overlap_fully?({{a_start, a_end}, {b_start, b_end}}) do
    ((a_start >= b_start) && (a_end <= b_end))
    || ((b_start >= a_start) && (b_end <= a_end))
  end

  def part1 do
    input()
    |> Enum.map(&assignment_pairs_to_sections/1)
    |> Enum.filter(&section_pairs_overlap_fully?/1)
    |> Enum.count()
  end

  def section_pairs_overlap_partly?({{a_start, a_end}, {b_start, b_end}}) do
    ((a_start <= b_start) && (a_end >= b_start))
    || ((a_start <= b_end) && (a_end >= b_end))
  end

  def section_pairs_overlap?(sections) do
    section_pairs_overlap_fully?(sections)
    || section_pairs_overlap_partly?(sections)
  end

  def part2 do
    input()
    |> Enum.map(&assignment_pairs_to_sections/1)
    |> Enum.filter(&section_pairs_overlap?/1)
    |> Enum.count
  end
end
