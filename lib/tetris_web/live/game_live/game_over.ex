defmodule TetrisWeb.GameLive.GameOver do
  @moduledoc false
  use TetrisWeb, :live_view
  alias Tetris.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(game: Map.get(socket.assigns, :game) || Game.new())}
  end

  defp play(socket) do
    socket
    |> push_redirect(to: "/game/playing")
  end

  @impl true
  def handle_event("play", _params, socket) do
    {:noreply, play(socket)}
  end
end
