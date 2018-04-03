defmodule DiversityInTechWeb.ReviewController do
  use DiversityInTechWeb, :controller

  alias DiversityInTech.Companies
  alias DiversityInTech.Companies.Review

  def new(conn, params) do
    company = Companies.get_company_by_slug!(params["company_slug"])
    changeset = Companies.change_review(%Review{company_id: company.id})

    render(conn, "new.html", changeset: changeset, company: company)
  end

  def create(conn, %{"review" => review_params} = params) do
    case Companies.create_review(review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: company_path(conn, :show, params["company_slug"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Companies.get_review!(id)
    render(conn, "show.html", review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = Companies.get_review!(id)
    changeset = Companies.change_review(review)

    render(
      conn,
      "edit.html",
      company: review.company,
      review: review,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Companies.get_review!(id)

    case Companies.update_review(review, review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(
          to: company_review_path(conn, :show, review.company.slug, review)
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", review: review, changeset: changeset)
    end
  end
end
