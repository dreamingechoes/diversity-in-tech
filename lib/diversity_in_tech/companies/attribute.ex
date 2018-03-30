defmodule DiversityInTech.Companies.Attribute do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.AttributeReview

  schema "attributes" do
    field(:description, :string)
    field(:name, :string)

    timestamps()

    # Associations
    has_many(:attributes_reviews, AttributeReview, on_delete: :delete_all)
  end

  # Changeset cast params
  @params [:name, :description]
  @required [:name]

  @doc false
  def changeset(attribute, attrs) do
    attribute
    |> cast(attrs, @params)
    |> validate_required(@required)
  end
end
