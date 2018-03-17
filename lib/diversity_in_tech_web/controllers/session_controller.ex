defmodule DiversityInTechWeb.SessionController do
  use DiversityInTechWeb, :controller

  plug(:put_layout, "auth.html")

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
  end

  def delete(conn, _) do
  end
end
