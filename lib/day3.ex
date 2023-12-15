defmodule Day3 do
  def part1(path) do
    lines = FileLoader.loadFile(path)

    lines
    |> Enum.map(&find_numbers_in_string/1)
  end

  def test_part1 do
    result = part1("priv/day3.ex1.txt")

    if result === 4361 do
      IO.puts("All good")
    else
      IO.puts("Invalid result: #{inspect(result)}")
    end
  end

  def solve_part1 do
    IO.puts("Result: #{part1("priv/day3.input.txt")}")
  end

  # def part2(path) do
  #   lines = FileLoader.loadFile(path)
  # end
  #
  # def test_part2 do
  #   result = part2("priv/day3.ex2.txt")
  #
  #   if result === 2286 do
  #     IO.puts("All good")
  #   else
  #     IO.puts("Invalid result: #{inspect(result)}")
  #   end
  # end
  #
  # def solve_part2 do
  #   IO.puts("Result: #{part2("priv/day2.input.txt")}")
  # end

  def find_numbers_in_string(line) do
    IO.puts(inspect(Regex.scan(~r/(\d)/, line, return: :index, capture: :all_but_first)))
  end
end
