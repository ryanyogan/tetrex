defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.{Tetromino, Game, Shapes}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {:ok, new_game(socket)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <section class="phx-hero" style="background: #fff;">
      <div phx-window-keydown="keystroke">
        <h1>Tetris!</h1>
        <%= render_board(assigns) %>
      </div>
    </section>
    """
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
      <%= for {x, y, shape} <- @game.points do %>
        <rect width="20" height="20" x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" style="fill:<%= color(shape) %>;" />
      <% end %>
    """
  end

  defp color(shape), do: Shapes.color(shape)

  def down(%{assigns: %{game: %{tetro: %{location: {_, 20}}}}} = socket) do
    socket
    |> new_tetromino()
  end

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

  def show(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(points: Tetromino.show(tetro))
  end

  def rotate(%{assigns: %{game: game}} = socket) do
    socket
    |> assign(game: Game.rotate(game))
  end

  defp new_game(socket) do
    socket
    |> assign(game: Game.new())
  end

  defp new_tetromino(socket) do
    socket
    |> assign(game: Game.new_tetromino(socket.assigns.game))
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket |> down()}
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
