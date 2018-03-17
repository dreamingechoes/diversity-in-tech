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
  end

  scope "/", DiversityInTechWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/users", UserController)
    resources("/session", SessionController, only: [:new, :create])
  end

  scope "/", DiversityInTechWeb do
    pipe_through(:browser_auth)

    resources("/companies", CompanyController, param: "slug")
    resources("/reviews", ReviewController)
    resources("/session", SessionController, only: [:delete])
  end
end
