defmodule DiversityInTech.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.Company


  schema "companies" do
    field :description, :string
    field :logo, :string
    field :name, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :description, :logo, :website])
    |> validate_required([:name, :description, :logo, :website])
  end
end
