defmodule Tetris.Game do
  defstruct [:tetro, points: [], score: 0, junkyard: %{}]

  alias Tetris.{Tetromino, Points}

  def move(game, move_fn) do
    old_tetro = game.tetro

    new_tetro =
      game.tetro
      |> move_fn.()

    valid_move? =
      new_tetro
      |> Tetromino.show()
      |> Points.valid?()

    Tetromino.maybe_move(old_tetro, new_tetro, valid_move?)
  end

  def right(game), do: game |> move(&Tetromino.right/1) |> show()
  def left(game), do: game |> move(&Tetromino.left/1) |> show()
  def rotate(game), do: game |> move(&Tetromino.rotate/1) |> show()

  def new_tetromino(game) do
    %{game | tetro: Tetromino.new_random()}
    |> show()
  end

  def show(game) do
    %{game | points: Tetromino.show(game.tetro)}
  end
end
