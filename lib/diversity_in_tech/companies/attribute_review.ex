defmodule DiversityInTech.Companies.AttributeReview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attributes_reviews" do
    field(:score, :integer)
    field(:attribute_id, :id)
    field(:review_id, :id)

    timestamps()
  end

  # Changeset cast params
  @params [:score]
  @required [:score]

  @doc false
  def changeset(attribute_review, attrs) do
    attribute_review
    |> cast(attrs, @params)
    |> validate_required(@required)
    |> cast_assoc(:attribute)
    |> cast_assoc(:review)
  end
end
