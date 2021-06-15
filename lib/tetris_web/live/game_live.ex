defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {:ok,
     socket
     |> new_tetromino()
     |> show()}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Tetris!</h1>
      <%= render_board(assigns) %>

      <pre>
        shape: <%= @tetro.shape %>
        rotation: <%= @tetro.rotation %>
      </pre>
    </section>
    """
  end

  defp render_board(assigns) do
    ~L"""
      <svg width="200" height="400">
        <rect width="200" height="400" style="fill:rgb(0,0,0);" />
        <%= render_points(assigns) %>
      </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
      <%= for {x, y} <- @points do %>
        <rect width="20" height="20" x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" style="fill:rgb(255,0,0);" />
      <% end %>
    """
  end

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino()
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.down(tetro))
  end

  def show(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(points: Tetromino.show(tetro))
  end

  defp new_tetromino(socket) do
    socket
    |> assign(tetro: Tetromino.new_random())
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket |> down() |> show()}
  end
end
