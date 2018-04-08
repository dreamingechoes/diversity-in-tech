defmodule DiversityInTechWeb.Router do
  use DiversityInTechWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :browser_auth do
    plug(DiversityInTechWeb.Guardian.AuthPipeline)
    plug(DiversityInTechWeb.Plug.CurrentUser)
  end

  pipeline :browser_ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(DiversityInTechWeb.Plug.CurrentUser)
  end

  scope "/", DiversityInTechWeb do
    # Application unauthenticated scope
    scope "/" do
      pipe_through([:browser, :browser_auth])

      # Logout route
      delete("/session/logout", SessionController, :delete)

      # Home route
      get("/", PageController, :index)

      resources(
        "/companies",
        CompanyController,
        only: [:index, :show],
        param: "slug"
      ) do
        resources("/reviews", ReviewController, only: [:new, :create])
      end

      resources("/session", SessionController, only: [:new, :create])
    end

    # Admin scope
    scope "/admin", Admin, as: :admin do
      pipe_through([:browser, :browser_auth, :browser_ensure_auth])

      resources("/attributes", AttributeController)
      resources("/companies", CompanyController, param: "slug")
      resources("/reviews", ReviewController)
      resources("/users", UserController)
    end
  end
end
