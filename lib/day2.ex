defmodule Advent2022.Day2 do
  # A/X = rock
  # B/Y = paper
  # C/Z = scissors
  @winning_instructions [
    ["A", "Y"],
    ["B", "Z"],
    ["C", "X"],
  ]

  @draw_instructions [
    ["A", "X"],
    ["B", "Y"],
    ["C", "Z"]
  ]

  @shape_scores %{
    "A" => 1,
    "X" => 1,
    "B" => 2,
    "Y" => 2,
    "C" => 3,
    "Z" => 3
  }

  def input do
    {:ok, data} = File.read("resources/day2.txt")
    data
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.filter(&(&1 != []))
  end

  def sum_of_my_choices(choice_pairs) do
    choice_pairs
    |> Enum.map(fn [_, my_choice] ->
      @shape_scores[my_choice]
    end)
    |> Enum.sum()
  end

  def sum_of_outcomes(choice_pairs) do
    Enum.map(choice_pairs, &get_outcome_score/1)
    |> Enum.sum()
  end

  def get_outcome_score(choice_pair) do
    case choice_pair do
      x when x in @winning_instructions -> 6
      x when x in @draw_instructions -> 3
      _ -> 0
    end
  end

  def part1 do
    choice_pairs = input()

    choices_sum = sum_of_my_choices(choice_pairs)
    outcome_sum = sum_of_outcomes(choice_pairs)

    choices_sum + outcome_sum
  end

  @this_loses_to_what %{
    "A" => "Y",
    "B" => "Z",
    "C" => "X",
  }

  @this_beats_what %{
    "A" => "Z",
    "B" => "X",
    "C" => "Y",
  }

  def part2 do
    instructions = input()

    outcome_sum = Enum.map(instructions, fn [_, strategy] ->
      case strategy do
        "X" -> 0
        "Y" -> 3
        "Z" -> 6
      end
    end)
    |> Enum.sum()

    choices_sum = Enum.map(instructions, fn [opp_choice, strategy] ->
      case strategy do
        "X" -> @shape_scores[@this_beats_what[opp_choice]]
        "Y" -> @shape_scores[opp_choice]
        "Z" -> @shape_scores[@this_loses_to_what[opp_choice]]
      end
    end)
    |> Enum.sum()

    outcome_sum + choices_sum
  end
end
