defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {3, 0}

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
    |> Points.move(tetro.location)
  end

  def points(%{shape: :l}), do: Shapes.shape_l()

  def points(%{shape: :j}), do: Shapes.shape_j()

  def points(%{shape: :o}), do: Shapes.shape_o()

  def points(%{shape: :i}), do: Shapes.shape_i()

  def points(%{shape: :t}), do: Shapes.shape_t()

  def points(%{shape: :s}), do: Shapes.shape_s()

  def points(%{shape: :z}), do: Shapes.shape_z()

  defp random_shape do
    Enum.random(@shapes)
  end

  defp rotate_degrees(270), do: 0
  defp rotate_degrees(n), do: n + 90
end
