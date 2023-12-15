defmodule Day1 do
  @moduledoc """
  Documentation for `Aoc2023Elixir`.
  """

  def is_number?(s) do
    case Integer.parse(s) do
      {_, ""} -> true
      _ -> false
    end
  end

  def generate_nums do
    1..9
    |> Enum.map(&Integer.to_string/1)
    |> Enum.with_index(1)
  end

  def generate_nums_and_strings do
    ~w(one two three four five six seven eight nine)
    |> Enum.with_index(1)
    |> (&(generate_nums() ++ &1)).()
  end

  def part1 do
    lines = FileLoader.loadFile("priv/day1.input.txt")

    IO.puts("### ENTRIES ###")

    value =
      lines
      |> Enum.filter(fn entry -> entry !== "\n" end)
      |> Enum.map(&String.replace(&1, "\n", ""))
      |> Enum.map(fn
        line ->
          entry = processLine(line, generate_nums())
          IO.puts("Total: #{entry}\n")
          entry
      end)
      |> Enum.sum()

    IO.puts("### RESULT ###")
    IO.puts(to_string(value))
    :ok
  end

  def part2 do
    lines = FileLoader.loadFile("priv/day1.input.txt")

    IO.puts("### ENTRIES ###")

    value =
      lines
      |> Enum.filter(fn entry -> entry !== "\n" end)
      |> Enum.map(&String.replace(&1, "\n", ""))
      |> Enum.map(fn
        line ->
          entry = processLine(line, generate_nums_and_strings())
          IO.puts("Total: #{entry}\n")
          entry
      end)
      |> Enum.sum()

    IO.puts("### RESULT ###")
    IO.puts(to_string(value))
    :ok
  end

  defp find_match(_, []) do
    nil
  end

  defp find_match("", _) do
    nil
  end

  defp find_match(line, [{key, value} | rest]) do
    IO.puts("Checking if #{line} starts with #{key}...")

    case String.starts_with?(line, key) do
      true -> value
      false -> find_match(line, rest)
    end
  end

  defp findFirstEntry(_, []) do
    nil
  end

  defp findFirstEntry("", _) do
    nil
  end

  defp findFirstEntry(line, map) do
    match = find_match(line, map)

    if match == nil do
      IO.puts("Unable to find match, slicing string!")
      findFirstEntry(String.slice(line, 1..-1), map)
    else
      IO.puts("Found match #{match}!")
      match
    end
  end

  defp processLine(line, map) do
    IO.puts("Using map: #{inspect(map)}")
    IO.puts("Looking for first entry in #{line}")
    first = findFirstEntry(line, map)
    IO.puts("Found #{first}")

    IO.puts("Looking for first entry in #{String.reverse(line)}")

    last =
      findFirstEntry(
        String.reverse(line),
        Enum.map(map, fn {key, value} -> {String.reverse(key), value} end)
      )

    IO.puts("Found #{last}")

    first * 10 + last
  end
end
