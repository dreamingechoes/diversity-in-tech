defmodule DiversityInTechWeb.Admin.CompanyController do
  use DiversityInTechWeb, :controller

  alias DiversityInTech.Companies
  alias DiversityInTech.Companies.Company

  plug(:put_layout, "admin.html")

  def index(conn, params) do
    companies = Companies.paginate_companies(params)
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Companies.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Companies.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(
          :info,
          dgettext("companies", "Company created successfully.")
        )
        |> redirect(to: admin_company_path(conn, :show, company.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug} = params) do
    company = Companies.get_company_by_slug!(slug)
    reviews = Companies.paginate_company_reviews(company.id, params)
    render(conn, "show.html", company: company, reviews: reviews)
  end

  def edit(conn, %{"slug" => slug}) do
    company = Companies.get_company_by_slug!(slug)
    changeset = Companies.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "company" => company_params}) do
    company = Companies.get_company_by_slug!(slug)

    case Companies.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(
          :info,
          dgettext("companies", "Company updated successfully.")
        )
        |> redirect(to: admin_company_path(conn, :show, company.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    company = Companies.get_company_by_slug!(slug)
    {:ok, _company} = Companies.delete_company(company)

    conn
    |> put_flash(:info, dgettext("companies", "Company deleted successfully."))
    |> redirect(to: admin_company_path(conn, :index))
  end
end
