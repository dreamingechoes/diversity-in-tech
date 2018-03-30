defmodule DiversityInTech.Repo.Migrations.CreateAttributes do
  use Ecto.Migration

  def change do
    create table(:attributes) do
      add(:name, :string)
      add(:description, :string)

      timestamps()
    end
  end
end
