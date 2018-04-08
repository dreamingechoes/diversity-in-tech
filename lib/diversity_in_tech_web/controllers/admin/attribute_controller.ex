defmodule DiversityInTechWeb.Admin.AttributeController do
  use DiversityInTechWeb, :controller

  alias DiversityInTech.Companies
  alias DiversityInTech.Companies.Attribute

  plug(:put_layout, "admin.html")

  def index(conn, _params) do
    attributes = Companies.list_attributes()
    render(conn, "index.html", attributes: attributes)
  end

  def new(conn, _params) do
    changeset = Companies.change_attribute(%Attribute{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attribute" => attribute_params}) do
    case Companies.create_attribute(attribute_params) do
      {:ok, attribute} ->
        conn
        |> put_flash(
          :info,
          dgettext("attributes", "Attribute created successfully.")
        )
        |> redirect(to: admin_attribute_path(conn, :show, attribute))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attribute = Companies.get_attribute!(id)
    render(conn, "show.html", attribute: attribute)
  end

  def edit(conn, %{"id" => id}) do
    attribute = Companies.get_attribute!(id)
    changeset = Companies.change_attribute(attribute)
    render(conn, "edit.html", attribute: attribute, changeset: changeset)
  end

  def update(conn, %{"id" => id, "attribute" => attribute_params}) do
    attribute = Companies.get_attribute!(id)

    case Companies.update_attribute(attribute, attribute_params) do
      {:ok, attribute} ->
        conn
        |> put_flash(
          :info,
          dgettext("attributes", "Attribute updated successfully.")
        )
        |> redirect(to: admin_attribute_path(conn, :show, attribute))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", attribute: attribute, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attribute = Companies.get_attribute!(id)
    {:ok, _attribute} = Companies.delete_attribute(attribute)

    conn
    |> put_flash(
      :info,
      dgettext("attributes", "Attribute deleted successfully.")
    )
    |> redirect(to: admin_attribute_path(conn, :index))
  end
end
