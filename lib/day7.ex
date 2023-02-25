defmodule Advent2022.Day7 do
  def input do
    {:ok, data} = File.read("resources/day7.txt")

    String.split(data, "$")
  end

  def parse_command(command_string) do
    command_string
    |> String.split("\n", trim: true)
  end
end

defmodule Advent2022.Day7.Directory do
  defstruct [:name, contents: []]
end

defmodule Advent2022.Day7.File do
  defstruct [:name, size: 0]
end

defmodule Advent2022.Day7.State do
  alias Advent2022.Day7.Directory

  defstruct [
    current_path: "/",
    file_tree: %Directory{name: "/", contents: []}
  ]
end
