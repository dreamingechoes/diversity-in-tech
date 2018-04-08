defmodule DiversityInTechWeb.CompanyController do
  use DiversityInTechWeb, :controller

  alias DiversityInTech.Companies

  def index(conn, params) do
    companies = Companies.paginate_companies(params)
    render(conn, "index.html", companies: companies)
  end

  def show(conn, %{"slug" => slug} = params) do
    company = Companies.get_company_by_slug!(slug)
    reviews = Companies.paginate_company_reviews(company.id, params)
    render(conn, "show.html", company: company, reviews: reviews)
  end
end
