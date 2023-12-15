defmodule FileLoader do
  def loadFile(path) do
    case File.open(path, [:read, :utf8]) do
      {:ok, file} -> IO.stream(file, :line)
      {:error, reason} -> raise "Oh no! #{reason}"
    end
  end
end
