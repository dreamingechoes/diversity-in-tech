defmodule DiversityInTech.Repo.Migrations.AddPasswordToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:password, :string, null: false)
    end
  end
end
