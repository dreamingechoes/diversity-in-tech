defmodule DiversityInTech.Repo.Migrations.AddStatusToReview do
  use Ecto.Migration

  def change do
    alter table(:reviews) do
      add(:status, :integer)
    end
  end
end
