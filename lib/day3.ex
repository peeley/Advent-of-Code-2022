defmodule Advent2022.Day3 do
  def input do
    {:ok, data} = File.read("resources/day3.txt")
    data
    |> String.split
    |> Enum.filter(&(&1 != ""))
  end

  def split_rucksack_into_compartments(rucksack) do
    String.split_at(rucksack, div(String.length(rucksack), 2))
    |> Tuple.to_list()
  end

  def find_common_component_in_compartments(compartments) do
    compartments
    |> Enum.map(&compartment_to_components/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
    |> List.first()
  end

  def get_priority_of_component(component) do
    case component do
      x when x in ?a..?z -> (x - 96)
      x when x in ?A..?Z -> (x - 38)
    end
  end

  def compartment_to_components(compartment) do
    compartment
    |> String.to_charlist()
    |> Enum.reduce(MapSet.new(), fn letter, set -> MapSet.put(set, letter) end)
  end

  def part1 do
    input()
    |> Enum.map(&split_rucksack_into_compartments/1)
    |> Enum.map(&find_common_component_in_compartments/1)
    |> Enum.map(&get_priority_of_component/1)
    |> Enum.sum
  end

  def convert_rucksack_to_item_set(rucksack) do
    rucksack
    |> String.to_charlist()
    |> Enum.reduce(MapSet.new, fn letter, set -> MapSet.put(set, letter) end)
  end

  def find_common_item_in_group(group_of_rucksacks) do
    group_of_rucksacks
    |> Enum.map(&convert_rucksack_to_item_set/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
    |> hd()
  end

  def get_priority_of_group(group_of_rucksacks) do
    group_of_rucksacks
    |> find_common_item_in_group()
    |> get_priority_of_component()
  end

  def part2 do
    input()
    |> Enum.chunk_every(3)
    |> Enum.map(&get_priority_of_group/1)
    |> Enum.sum()
  end
end
