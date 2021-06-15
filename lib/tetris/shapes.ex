defmodule Tetris.Shapes do
  @moduledoc """
  `Shapes` contains functions that return the `Point` value for each
  individual shape to construct them visually.
  """
  def shape(:l),
    do: [{2, 1}, {2, 2}, {2, 3}, {3, 3}]

  def shape(:j),
    do: [{3, 1}, {3, 2}, {2, 3}, {3, 3}]

  def shape(:o),
    do: [{2, 2}, {3, 2}, {2, 3}, {3, 3}]

  def shape(:i),
    do: [{2, 1}, {2, 2}, {2, 3}, {2, 4}]

  def shape(:t),
    do: [{1, 2}, {2, 2}, {3, 2}, {2, 3}]

  def shape(:s),
    do: [{2, 2}, {3, 2}, {1, 3}, {2, 3}]

  def shape(:z),
    do: [{1, 2}, {2, 2}, {2, 3}, {3, 3}]

  # If error occurs simply return the L shape
  def shape(_),
    do: [{2, 1}, {2, 2}, {2, 3}, {3, 3}]

  def color(:l), do: "red"
  def color(:j), do: "blue"
  def color(:s), do: "green"
  def color(:z), do: "yellow"
  def color(:o), do: "aqua"
  def color(:i), do: "coral"
  def color(:t), do: "deeppink"
  def color(_), do: "red"
end
