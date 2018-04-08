defmodule DiversityInTech.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias DiversityInTech.Accounts.Managers.User, as: UserManager

  # User API
  defdelegate list_users, to: UserManager
  defdelegate get_user!(id), to: UserManager
  defdelegate get_user_by_username_or_email!(us_or_em), to: UserManager
  defdelegate create_user(attrs), to: UserManager
  defdelegate update_user(user, attrs), to: UserManager
  defdelegate delete_user(user), to: UserManager
  defdelegate change_user(user), to: UserManager
end
