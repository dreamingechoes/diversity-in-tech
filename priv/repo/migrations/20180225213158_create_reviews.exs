defmodule DiversityInTech.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add(:pros, :text)
      add(:cons, :text)
      add(:advice, :text)
      add(:company_id, references(:companies, on_delete: :delete_all))

      timestamps()
    end

    create(index(:reviews, [:company_id]))
  end
end
