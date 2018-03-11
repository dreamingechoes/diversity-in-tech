defmodule DiversityInTech.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.Company

  schema "companies" do
    field(:name, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:logo, :string)
    field(:website, :string)

    timestamps()
  end

  # Changeset cast params
  @params [:name, :description, :logo, :website]
  @required [:name]

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, @params)
    |> validate_required(@required)
    |> generate_slug()
  end

  defp generate_slug(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        slug =
          name
          |> String.downcase()
          |> String.replace(" ", "-")

        put_change(current_changeset, :slug, slug)

      _ ->
        current_changeset
    end
  end
end
