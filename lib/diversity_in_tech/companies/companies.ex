defmodule DiversityInTech.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias DiversityInTech.Repo
  alias DiversityInTech.Companies.Company
  alias Ecto.Multi

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Returns the list of companies paginated.

  ## Examples

      iex> paginate_companies(attrs)
      %Scrivener.Page{entries: [%Company{}], page_number: 1,
        page_size: 1, total_entries: 1, total_pages: 1}

  """
  def paginate_companies(attrs) do
    Repo.paginate(Company, attrs)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Gets a single company by its slug.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company_by_slug!("company-slug")
      %Company{}

      iex> get_company_by_slug!("company-slug")
      ** (Ecto.NoResultsError)

  """
  def get_company_by_slug!(slug) do
    query = from(company in Company, where: company.slug == ^slug)
    Repo.one!(query)
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    changeset =
      %Company{}
      |> Company.changeset(attrs)

    result =
      Multi.new()
      |> Multi.insert(:company, changeset)
      |> Multi.run(:logo, &create_logo(&1, attrs))
      |> Repo.transaction()

    case result do
      {:ok, changes} -> {:ok, changes.company}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    changeset =
      company
      |> Company.changeset(attrs)

    result =
      Multi.new()
      |> Multi.update(:company, changeset)
      |> Multi.run(:old_logo, &delete_logo(&1))
      |> Multi.run(:logo, &create_logo(&1, attrs))
      |> Repo.transaction()

    case result do
      {:ok, changes} -> {:ok, changes.company}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  @doc """
  Deletes a Company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    result =
      Multi.new()
      |> Multi.delete(:company, company)
      |> Multi.run(:old_logo, &delete_logo(&1))
      |> Repo.transaction()

    case result do
      {:ok, changes} -> {:ok, changes.company}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{source: %Company{}}

  """
  def change_company(%Company{} = company) do
    Company.changeset(company, %{})
  end

  alias DiversityInTech.Companies.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Returns the list of reviews of a certain company.

  ## Examples

      iex> paginate_company_reviews(company_id, attrs)
      %Scrivener.Page{entries: [%Review{}], page_number: 1,
        page_size: 1, total_entries: 1, total_pages: 1}

  """
  def paginate_company_reviews(company_id, attrs) do
    from(review in Review, where: review.company_id == ^company_id)
    |> Repo.paginate(attrs)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{source: %Review{}}

  """
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end

  # Private functions
  defp create_logo(%{company: company}, attrs) do
    company
    |> Company.logo_changeset(attrs)
    |> Repo.update()
  end

  defp delete_logo(%{company: company}) do
    path =
      DiversityInTech.Uploader.file_path(
        company,
        company.logo,
        DiversityInTech.Uploaders.Image
      )

    case DiversityInTech.Uploaders.Image.delete({path, company}) do
      :ok -> {:ok, company}
      _ -> {:error, company}
    end
  end
end
