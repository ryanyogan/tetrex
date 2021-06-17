defmodule Tetris.Tetromino do
  @moduledoc false
  defstruct shape: :l, rotation: 0, location: {3, -4}

  alias Tetris.{Point, Points, Shapes}

  @shapes ~w[i t o l j z s]a
  @doc """
  The new function is used for iex and testing, the game uses `new_random/0`
  """
  def new(options \\ []) do
    __struct__(options)
  end

  def new_random do
    new(shape: random_shape())
  end

  def right(tetro) do
    %{tetro | location: Point.right(tetro.location)}
  end

  def left(tetro) do
    %{tetro | location: Point.left(tetro.location)}
  end

  def down(tetro) do
    %{tetro | location: Point.down(tetro.location)}
  end

  def rotate(tetro) do
    %{tetro | rotation: rotate_degrees(tetro.rotation)}
  end

  def show(tetro) do
    tetro
    |> points()
    |> Points.rotate(tetro.rotation)
    |> Points.move(tetro.location)
    |> Points.add_shape(tetro.shape)
  end

  def points(tetro), do: Shapes.shape(tetro.shape)

  def maybe_move(_old, new, true = _valid),
    do: new

  def maybe_move(old, _new, false = _valid),
    do: old

  defp random_shape do
    Enum.random(@shapes)
  end

  defp rotate_degrees(270), do: 0
  defp rotate_degrees(n), do: n + 90
end
