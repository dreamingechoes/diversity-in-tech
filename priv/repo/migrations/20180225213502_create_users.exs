defmodule DiversityInTech.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:name, :string)
      add(:surname, :string)
      add(:username, :string)
      add(:role, :integer)

      timestamps()
    end
  end
end
