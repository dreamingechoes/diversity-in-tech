defmodule DiversityInTech.Accounts.Queries.User do
  @moduledoc """
  User queries.

  On this module, we have all the methods we need to manage
  the queries to interact with `User` schema.
  """

  import Ecto.Query, warn: false

  alias DiversityInTech.Accounts.Schemas.User

  def by_default, do: from(u in User, order_by: [asc: :name])

  def by_username_or_email(query, username_or_email) do
    from(
      u in query,
      where: u.username == ^username_or_email or u.email == ^username_or_email
    )
  end
end
