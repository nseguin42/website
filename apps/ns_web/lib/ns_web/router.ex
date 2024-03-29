defmodule NsWeb.Router do
  use NsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {NsWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(PlugContentSecurityPolicy)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", NsWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
    # get("/about", PageController, :about)
    # get("/contact", PageController, :contact)
    # get("/resume", PageController, :resume)
    get("/test", PageController, :test)
    # get("/latex", PageController, :latex)
  end

  scope "/api", NsWeb do
    pipe_through(:api)

    resources("/commits", CommitController, except: [:new, :edit])
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ns_web, :dev_routes) do
    require Logger
    Logger.info("Enabling dev routes")
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: NsWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
