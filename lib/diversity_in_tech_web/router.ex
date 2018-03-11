defmodule DiversityInTechWeb.Router do
  use DiversityInTechWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", DiversityInTechWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/companies", CompanyController)
    resources("/reviews", ReviewController)
    resources("/users", UserController)
  end
end
