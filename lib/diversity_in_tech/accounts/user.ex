defmodule DiversityInTech.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Accounts.User

  schema "users" do
    field(:email, :string)
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
  end
end
