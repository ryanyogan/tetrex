defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {:ok,
     socket
     |> new_tetromino()}
  end

  def new_tetromino(socket) do
    socket
    |> assign(tetro: Tetromino.new_random())
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(tetro: Tetromino.down(tetro))
  end

  @impl true
  def render(assigns) do
    ~L"""
    <% {x, y} = @tetro.location %>
    <section class="phx-hero">
      <pre>
        shape: <%= @tetro.shape %>
        rotation: <%= @tetro.rotation %>
        location: {<%= x %>, <%= y %>}
      </pre>
    </section>
    """
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end
end
