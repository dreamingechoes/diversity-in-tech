defmodule DiversityInTech.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :pros, :text
      add :cons, :text
      add :advice, :text
      add :company_id, :integer

      timestamps()
    end

  end
end
