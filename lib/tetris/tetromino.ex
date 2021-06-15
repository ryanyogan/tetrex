defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {5, 1}

  @shapes ~w[i t o l j z s]a
  def new(options \\ []) do
    __struct__(options)
  end

  def new_random do
    new(shape: random_shape())
  end

  defp random_shape do
    Enum.random(@shapes)
  end
end
