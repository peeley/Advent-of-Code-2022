defmodule Advent2022.Day5 do
  def input do
    {:ok, data} = File.read("resources/day5.txt")
    [stacks, instructions] = String.split(data, "\n\n")

    [stacks, instructions]
  end

  def test_input do
    [stacks, instructions] = String.split("""
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """, "\n\n")

    [stacks, instructions]
  end

  def parse_stacks(stacks) do
    stacks
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(&parse_stack_line/1)
    |> Enum.reduce(%{}, &add_stack_line_to_stacks/2)
  end

  def parse_stack_line(stack_line) do
    stack_line
    |> String.split("", trim: true)
    |> Enum.chunk_every(4)
    |> Enum.map(fn stack_block_chars ->
      stack_block_chars
      |> Enum.filter(&(&1 != "[" && &1 != "]" && &1 != " "))
    end)
    |> Enum.map(fn
      [letter] -> letter
      [] -> nil
    end)
  end

  def add_stack_line_to_stacks(stack_line, stacks) do
    stack_line
    |> Enum.with_index()
    |> Enum.reduce(stacks, fn
      {nil, _idx}, acc -> acc
      {letter, idx}, acc -> Map.update(acc, idx+1, [letter], &(&1 ++ [letter]))
    end)
  end

  def parse_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, amount, _, start_pos, _, end_pos] = String.split(line, " ", trim: true)

      [amount, start_pos, end_pos]
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def perform_instruction_on_stack(instruction, stacks) do
    [amount, start_pos, end_pos] = instruction
    moved_letters = Enum.take(stacks[start_pos], amount) |> Enum.reverse()

    stacks
    |> Map.update(start_pos, stacks[start_pos], &(Enum.drop(&1, amount)))
    |> Map.update(end_pos, stacks[end_pos], fn list_at_end_pos ->
      List.flatten([moved_letters | list_at_end_pos])
    end)
  end

  def part1 do
    [stacks, instructions] = input()
    parsed_stacks = parse_stacks(stacks)
    parsed_instructions = parse_instructions(instructions)

    Enum.reduce(parsed_instructions, parsed_stacks, &perform_instruction_on_stack/2)
  end
end
