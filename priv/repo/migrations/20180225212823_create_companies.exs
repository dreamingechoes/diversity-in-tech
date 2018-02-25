defmodule DiversityInTech.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :description, :text
      add :logo, :string
      add :website, :string

      timestamps()
    end

  end
end
