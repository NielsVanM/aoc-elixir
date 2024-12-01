defmodule SimilarityScore do
  def run() do
    dataset =
      load_file()
      |> String.split("\n")
      |> Enum.reverse()
      |> tl()
      |> Enum.reverse()
      |> Enum.reduce({[], []}, fn val, {left_acc, right_acc} ->
        case String.split(val, "   ", parts: 2) do
          [left, right] ->
            {[Integer.parse(left) |> elem(0) | left_acc],
             [Integer.parse(right) |> elem(0) | right_acc]}
        end
      end)

    uniques = Enum.frequencies(dataset |> elem(0))

    IO.inspect(uniques)

    result =
      dataset
      |> elem(1)
      |> Enum.reduce(0, fn val, acc ->
        Map.get(uniques, val, 0) * val + acc
      end)

    IO.inspect(result)
  end

  def load_file() do
    {:ok, contents} = File.read("./input.txt")

    contents
  end
end
