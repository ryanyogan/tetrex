defmodule TetrisWeb.Router do
  use TetrisWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TetrisWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TetrisWeb do
    pipe_through :browser

    live "/game", GameLive.Welcome, :welcome
    live "/game/playing", GameLive.Playing, :playing
    live "/game/over", GameLive.GameOver, :game_over
    live "/", PageLive, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TetrisWeb.Telemetry
    end
  end
end
