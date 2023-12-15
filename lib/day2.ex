defmodule Day2 do
  @color_limits %{red: 12, green: 13, blue: 14}

  def part1(path) do
    lines = FileLoader.loadFile(path)

    lines
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&validate_game?/1)
    |> Enum.map(fn game -> elem(game, 0) end)
    |> Enum.sum()
  end

  def part2(path) do
    lines = FileLoader.loadFile(path)

    lines
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&parse_line/1)
    |> Enum.map(&minimize_game/1)
    |> Enum.map(&power_of_set/1)
    |> Enum.sum()
  end

  def test_part1 do
    result = part1("priv/day2.ex1.txt")

    if result === 8 do
      IO.puts("All good")
    else
      IO.puts("Invalid result: #{inspect(result)}")
    end
  end

  def solve_part1 do
    IO.puts("Result: #{part1("priv/day2.input.txt")}")
  end

  def test_part2 do
    result = part2("priv/day2.ex1.txt")

    if result === 2286 do
      IO.puts("All good")
    else
      IO.puts("Invalid result: #{inspect(result)}")
    end
  end

  def solve_part2 do
    IO.puts("Result: #{part2("priv/day2.input.txt")}")
  end

  defp parse_line(line) do
    line
    |> String.split(": ")
    |> (fn [game_str, batches_str] ->
          {
            String.slice(game_str, 5..-1) |> String.to_integer(),
            String.split(batches_str, "; ")
            |> Enum.map(&parse_batch/1)
            |> Enum.map(&Map.new/1)
          }
        end).()
  end

  defp parse_batch(batch_str) do
    batch_str
    |> String.split(", ")
    |> Enum.map(&parse_color/1)
  end

  defp parse_color(color_str) do
    [count, color] = String.split(color_str, " ")
    {String.to_atom(color), count |> String.to_integer()}
  end

  defp validate_game?(game) do
    batches = elem(game, 1)

    batches
    |> Enum.all?(fn batch ->
      Enum.all?(batch, fn {color, value} -> value <= Map.get(@color_limits, color) end)
    end)
  end

  defp minimize_game(game) do
    batches = elem(game, 1)

    batches
    |> Enum.reduce(%{red: 0, blue: 0, green: 0}, fn batch, acc ->
      %{
        red: max(batch[:red] || 0, acc.red),
        blue: max(batch[:blue] || 0, acc.blue),
        green: max(batch[:green] || 0, acc.green)
      }
    end)

    # red_min =
    #   batches
    #   |> Enum.map(fn batch -> batch[:red] || 0 end)
    #   |> Enum.max()
    #
    # blue_min =
    #   batches
    #   |> Enum.map(fn batch -> batch[:blue] || 0 end)
    #   |> Enum.max()
    #
    # green_min =
    #   batches
    #   |> Enum.map(fn batch -> batch[:green] || 0 end)
    #   |> Enum.max()
    #
    # %{
    #   # gameId: elem(game, 0),
    #   # minimized: %{
    #   red: red_min,
    #   blue: blue_min,
    #   green: green_min
    #   # }
    # }
  end

  # Can also use Enum.product/1
  defp power_of_set(set) do
    Enum.reduce(set, 1, fn {_, value}, acc -> value * acc end)
  end
end
