defmodule DiversityInTech.Repo.Migrations.AddSlugToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add(:slug, :string, default: "", null: false)
    end
  end
end
