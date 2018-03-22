defmodule DiversityInTech.Companies.Company do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.Company

  schema "companies" do
    field(:name, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:logo, DiversityInTech.Uploaders.Image.Type)
    field(:website, :string)

    timestamps()
  end

  # Changeset cast params
  @params [:name, :description, :website]
  @required [:name]

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, @params)
    |> validate_required(@required)
    |> generate_slug()
  end

  def logo_changeset(struct, attrs) do
    struct
    |> cast_attachments(attrs, [:logo])
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
