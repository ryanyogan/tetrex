defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.{Tetromino, Shapes}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {:ok,
     socket
     |> new_tetromino()
     |> show()}
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
      <%= for {x, y, shape} <- @points do %>
        <rect width="20" height="20" x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" style="fill:<%= color(shape) %>;" />
      <% end %>
    """
  end

  defp color(shape), do: Shapes.color(shape)

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino()
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.down(tetro))
  end

  def left(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.left(tetro))
  end

  def right(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.right(tetro))
  end

  def show(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(points: Tetromino.show(tetro))
  end

  def rotate(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.rotate(tetro))
  end

  defp new_tetromino(socket) do
    socket
    |> assign(tetro: Tetromino.new_random())
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket |> down() |> show()}
  end

  @rotate_keys [" ", "ArrowDown"]
  @impl true
  def handle_event("keystroke", %{"key" => key}, socket) when key in @rotate_keys do
    {:noreply, socket |> rotate() |> show()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> left() |> show()}
  end

  @impl true
  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> right() |> show()}
  end

  @impl true
  def handle_event("keystroke", _params, socket) do
    {:noreply, socket}
  end
end
