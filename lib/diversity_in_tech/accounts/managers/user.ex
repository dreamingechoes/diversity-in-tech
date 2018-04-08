defmodule DiversityInTech.Accounts.Managers.User do
  @moduledoc """
  User manager.

  On this module, we have all the methods we need to manage
  the `User` schema.
  """

  alias DiversityInTech.Repo
  alias DiversityInTech.Accounts.Queries.User, as: Query
  alias DiversityInTech.Accounts.Schemas.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users, do: Query.by_default() |> Repo.all()

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Query.by_default() |> Repo.get!(id)

  @doc """
  Gets a single user by username or email.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_username_or_email!("username")
      %User{}

      iex> get_user_by_username_or_email!("username")
      ** (Ecto.NoResultsError)

  """
  def get_user_by_username_or_email!(username_or_email) do
    Query.by_default()
    |> Query.by_username_or_email(username_or_email)
    |> Repo.one!()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user), do: Repo.delete(user)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user), do: User.changeset(user, %{})
end
