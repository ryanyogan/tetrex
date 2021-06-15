defmodule Tetris.Shapes do
  @moduledoc """
  `Shapes` contains functions that return the `Point` value for each
  individual shape to construct them visually.
  """
  def shape_l,
    do: [{2, 1}, {2, 2}, {2, 3}, {3, 3}]

  def shape_j,
    do: [{3, 1}, {3, 2}, {2, 3}, {3, 3}]

  def shape_o,
    do: [{2, 2}, {3, 2}, {2, 3}, {3, 3}]

  def shape_i,
    do: [{2, 1}, {2, 2}, {2, 3}, {2, 4}]

  def shape_t,
    do: [{1, 2}, {2, 2}, {3, 2}, {2, 3}]

  def shape_s,
    do: [{2, 2}, {3, 2}, {1, 3}, {2, 3}]

  def shape_z,
    do: [{1, 2}, {2, 2}, {2, 3}, {3, 3}]
end
