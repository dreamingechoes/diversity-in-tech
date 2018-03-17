defmodule DiversityInTech.Guardian do
  use Guardian, otp_app: :diversity_in_tech
  import DiversityInTechWeb.Gettext
  import Ecto.Query
  alias Comeonin.Bcrypt
  alias DiversityInTech.Accounts.User
  alias DiversityInTech.Repo

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    {:ok, %{id: claims["sub"]}}
  end

  def authenticate_user(username_or_email, password) do
    query =
      from(
        u in User,
        where: u.username == ^username_or_email or u.email == ^username_or_email
      )

    Repo.one(query)
    |> check_password(password)
  end

  defp check_password(nil, _),
    do: {:error, gettext("Incorrect username or password")}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password) do
      true -> {:ok, user}
      false -> {:error, gettext("Incorrect username or password")}
    end
  end
end
