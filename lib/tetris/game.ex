defmodule Tetris.Game do
  defstruct [:tetro, score: 0, junkyard: %{}]

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
end
