defmodule DiversityInTech.Companies.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias DiversityInTech.Companies.Review

  schema "reviews" do
    field(:advice, :string)
    field(:cons, :string)
    field(:pros, :string)
    field(:company_id, :integer)

    timestamps()
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
