defmodule MangoWeb.Router do
  use MangoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :frontend do
    # Add plugs related to frontend
    plug MangoWeb.Plugs.LoadCustomer
    plug MangoWeb.Plugs.FetchCart
    plug MangoWeb.Plugs.Locale
  end

  pipeline :admin do
    plug MangoWeb.Plugs.AdminLayout
  end

  scope "/", MangoWeb do
    pipe_through [:browser, :frontend]

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create

    get "/", PageController, :index
    get "/categories/:name", CategoryController, :show
    post "/cart", CartController, :add
    get "/cart", CartController, :show
    put "/cart", CartController, :update
  end

  scope "/", MangoWeb do
    pipe_through [:browser, :frontend, MangoWeb.Plugs.AuthenticateCustomer]

    get "/logout", SessionController, :delete
    get "/checkout", CheckoutController, :edit
    put "/checkout", CheckoutController, :update
    resources "/tickets", TicketController
  end

  scope "/admin", MangoWeb.Admin, as: :admin do
    pipe_through [:browser, :admin]

    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MangoWeb do
  #   pipe_through :api
  # end
end
