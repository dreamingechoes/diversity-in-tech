defmodule DiversityInTech.Repo.Migrations.CreateAttributesReviews do
  use Ecto.Migration

  def change do
    create table(:attributes_reviews) do
      add(:score, :integer)
      add(:attribute_id, references(:attributes, on_delete: :delete_all))
      add(:review_id, references(:reviews, on_delete: :delete_all))

      timestamps()
    end

    create(index(:attributes_reviews, [:attribute_id]))
    create(index(:attributes_reviews, [:review_id]))
  end
end
