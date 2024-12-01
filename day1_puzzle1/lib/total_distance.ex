defmodule PuzzleParser do
  def run() do
    distance =
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
      |> Tuple.to_list()
      |> Enum.map(&Enum.sort/1)
      |> List.to_tuple()
      |> (fn {left, right} -> Enum.zip(left, right) end).()
      |> Enum.reduce(0, fn {left, right}, acc -> abs(left - right) + acc end)

    IO.inspect(distance)
  end

  def load_file() do
    {:ok, contents} = File.read("./input.txt")

    contents
  end
end
