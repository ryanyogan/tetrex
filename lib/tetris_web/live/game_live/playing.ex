defmodule TetrisWeb.GameLive.Playing do
  @moduledoc false
  use TetrisWeb, :live_view
  alias Tetris.{Game, Shapes}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {:ok, new_game(socket)}
  end

  defp render_board(assigns) do
    ~L"""
      <svg width="200" height="400">
        <rect width="200" height="400" style="fill:rgb(0,0,0);" />
        <%= render_shapes(assigns) %>
      </svg>
    """
  end

  defp render_shapes(assigns) do
    ~L"""
      <%= for {x, y, shape} <- @game.points ++ Game.junkyard_points(@game) do %>
        <rect width="20" height="20" x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" style="fill:<%= color(shape) %>;" />
      <% end %>
    """
  end

  defp color(shape), do: Shapes.color(shape)

  def down(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.down(game))
  end

  def left(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.left(game))
  end

  def right(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.right(game))
  end

  def show(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.show(game))
  end

  def rotate(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.rotate(game))
  end

  defp new_game(socket) do
    socket
    |> assign(game: Game.new())
  end

  defp maybe_end_game(%{assigns: %{game: %{game_over: true}}} = socket) do
    socket
    |> push_redirect(to: "/game/over?score=#{socket.assigns.game.score}")
  end

  defp maybe_end_game(socket), do: socket

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket |> down() |> maybe_end_game()}
  end

  @rotate_keys [" ", "ArrowUp"]
  @impl true
  def handle_event("keystroke", %{"key" => key}, socket) when key in @rotate_keys do
    {:noreply, socket |> rotate()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> left()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> right()}
  end

  @impl true
  def handle_event("keystroke", _params, socket) do
    {:noreply, socket}
  end
end
