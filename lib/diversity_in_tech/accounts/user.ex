defmodule DiversityInTech.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :role, :integer
    field :surname, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :surname, :username, :role])
    |> validate_required([:email, :name, :surname, :username, :role])
  end
end
