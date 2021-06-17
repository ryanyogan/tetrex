defmodule TetrisWeb.GameLive.GameOver do
  @moduledoc false
  use TetrisWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(score: params["score"] || 0)}
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
