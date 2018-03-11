defmodule DiversityInTech.Companies.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.Review

  schema "reviews" do
    field(:advice, :string)
    field(:company_id, :integer)
    field(:cons, :string)
    field(:pros, :string)

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [:pros, :cons, :advice, :company_id])
    |> validate_required([:pros, :cons, :advice, :company_id])
  end
end
