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
    pipe_through([:browser, :browser_auth, :browser_ensure_auth])

    # Logout route
    delete("/session/logout", SessionController, :delete)

    resources(
      "/companies",
      CompanyController,
      only: [:new, :create, :edit, :update, :delete],
      param: "slug"
    ) do
      resources("/reviews", ReviewController, except: [:delete])
    end

    resources("/users", UserController)
  end

  scope "/", DiversityInTechWeb do
    pipe_through([:browser, :browser_auth])

    get("/", PageController, :index)

    resources(
      "/companies",
      CompanyController,
      only: [:index, :show],
      param: "slug"
    )

    resources("/session", SessionController, only: [:new, :create])
  end
end
