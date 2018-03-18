defmodule DiversityInTech.Guardian do
  use Guardian, otp_app: :diversity_in_tech
  import DiversityInTechWeb.Gettext
  alias Comeonin.Bcrypt
  alias DiversityInTech.Accounts

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    resource = Accounts.get_user!(id)
    {:ok, resource}
  end

  def authenticate_user(username_or_email, password) do
    username_or_email
    |> Accounts.get_user_by_username_or_email!()
    |> check_password(password)
  end

  defp check_password(nil, _),
    do: {:error, gettext("Incorrect username or password")}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.encrypted_password) do
      true -> {:ok, user}
      false -> {:error, gettext("Incorrect username or password")}
    end
  end
end
