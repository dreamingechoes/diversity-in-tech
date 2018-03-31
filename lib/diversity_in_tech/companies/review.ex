defmodule DiversityInTech.Companies.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.AttributeReview
  alias DiversityInTech.Companies.Review

  schema "reviews" do
    field(:advice, :string)
    field(:cons, :string)
    field(:pros, :string)
    field(:company_id, :id)

    timestamps()

    # Associations
    has_many(:attributes_reviews, AttributeReview, on_delete: :delete_all)
  end

  # Changeset cast params
  @params [:pros, :cons, :advice, :company_id]
  @required [:company_id]

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, @params)
    |> validate_required(@required)
  end
end
