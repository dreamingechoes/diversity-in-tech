defmodule DiversityInTech.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt
  alias DiversityInTech.Accounts.User

  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:name, :string)
    field(:role, :integer)
    field(:surname, :string)
    field(:username, :string)

    timestamps()
  end

  # Changeset cast params
  @params [:email, :name, :surname, :username, :role]
  @required [:email, :username]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @params)
    |> validate_required(@required)
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} =
           changeset
       ) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp generate_encrypted_password(changeset), do: changeset
end
