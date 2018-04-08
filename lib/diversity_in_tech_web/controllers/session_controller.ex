defmodule DiversityInTechWeb.SessionController do
  use DiversityInTechWeb, :controller
  alias DiversityInTech.Guardian
  alias DiversityInTech.Guardian.Plug

  plug(:put_layout, "auth.html")

  def new(conn, _), do: render(conn, "new.html")

  def create(conn, %{
        "session" => %{
          "username_or_email" => username_or_email,
          "password" => password
        }
      }) do
    case Guardian.authenticate_user(username_or_email, password) do
      {:ok, user} ->
        conn
        |> Plug.sign_in(user)
        |> put_flash(:success, gettext("Welcome to Diversity In Tech!"))
        |> redirect(to: page_path(conn, :index))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> Plug.sign_out()
    |> redirect(to: page_path(conn, :index))
  end
end
