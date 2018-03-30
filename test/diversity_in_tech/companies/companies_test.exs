defmodule DiversityInTech.CompaniesTest do
  use DiversityInTech.DataCase

  alias DiversityInTech.Companies

  describe "companies" do
    alias DiversityInTech.Companies.Company

    @valid_attrs %{
      description: "some description",
      logo: "some logo",
      name: "some name",
      website: "some website"
    }
    @update_attrs %{
      description: "some updated description",
      logo: "some updated logo",
      name: "some updated name",
      website: "some updated website"
    }
    @invalid_attrs %{description: nil, logo: nil, name: nil, website: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} =
               Companies.create_company(@valid_attrs)

      assert company.description == "some description"
      assert company.logo == "some logo"
      assert company.name == "some name"
      assert company.website == "some website"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = Companies.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.description == "some updated description"
      assert company.logo == "some updated logo"
      assert company.name == "some updated name"
      assert company.website == "some updated website"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Companies.update_company(company, @invalid_attrs)

      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)

      assert_raise Ecto.NoResultsError, fn ->
        Companies.get_company!(company.id)
      end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end

  describe "reviews" do
    alias DiversityInTech.Companies.Review

    @valid_attrs %{
      advice: "some advice",
      company_id: 42,
      cons: "some cons",
      pros: "some pros"
    }
    @update_attrs %{
      advice: "some updated advice",
      company_id: 43,
      cons: "some updated cons",
      pros: "some updated pros"
    }
    @invalid_attrs %{advice: nil, company_id: nil, cons: nil, pros: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Companies.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Companies.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = Companies.create_review(@valid_attrs)
      assert review.advice == "some advice"
      assert review.company_id == 42
      assert review.cons == "some cons"
      assert review.pros == "some pros"
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Companies.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, review} = Companies.update_review(review, @update_attrs)
      assert %Review{} = review
      assert review.advice == "some updated advice"
      assert review.company_id == 43
      assert review.cons == "some updated cons"
      assert review.pros == "some updated pros"
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Companies.update_review(review, @invalid_attrs)

      assert review == Companies.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Companies.delete_review(review)

      assert_raise Ecto.NoResultsError, fn ->
        Companies.get_review!(review.id)
      end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Companies.change_review(review)
    end
  end

  describe "attributes" do
    alias DiversityInTech.Companies.Attribute

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{description: nil, name: nil}

    def attribute_fixture(attrs \\ %{}) do
      {:ok, attribute} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_attribute()

      attribute
    end

    test "list_attributes/0 returns all attributes" do
      attribute = attribute_fixture()
      assert Companies.list_attributes() == [attribute]
    end

    test "get_attribute!/1 returns the attribute with given id" do
      attribute = attribute_fixture()
      assert Companies.get_attribute!(attribute.id) == attribute
    end

    test "create_attribute/1 with valid data creates a attribute" do
      assert {:ok, %Attribute{} = attribute} =
               Companies.create_attribute(@valid_attrs)

      assert attribute.description == "some description"
      assert attribute.name == "some name"
    end

    test "create_attribute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Companies.create_attribute(@invalid_attrs)
    end

    test "update_attribute/2 with valid data updates the attribute" do
      attribute = attribute_fixture()

      assert {:ok, attribute} =
               Companies.update_attribute(attribute, @update_attrs)

      assert %Attribute{} = attribute
      assert attribute.description == "some updated description"
      assert attribute.name == "some updated name"
    end

    test "update_attribute/2 with invalid data returns error changeset" do
      attribute = attribute_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Companies.update_attribute(attribute, @invalid_attrs)

      assert attribute == Companies.get_attribute!(attribute.id)
    end

    test "delete_attribute/1 deletes the attribute" do
      attribute = attribute_fixture()
      assert {:ok, %Attribute{}} = Companies.delete_attribute(attribute)

      assert_raise Ecto.NoResultsError, fn ->
        Companies.get_attribute!(attribute.id)
      end
    end

    test "change_attribute/1 returns a attribute changeset" do
      attribute = attribute_fixture()
      assert %Ecto.Changeset{} = Companies.change_attribute(attribute)
    end
  end

  describe "attributes_reviews" do
    alias DiversityInTech.Companies.AttributeReview

    @valid_attrs %{score: 42}
    @update_attrs %{score: 43}
    @invalid_attrs %{score: nil}

    def attribute_review_fixture(attrs \\ %{}) do
      {:ok, attribute_review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_attribute_review()

      attribute_review
    end

    test "list_attributes_reviews/0 returns all attributes_reviews" do
      attribute_review = attribute_review_fixture()
      assert Companies.list_attributes_reviews() == [attribute_review]
    end

    test "get_attribute_review!/1 returns the attribute_review with given id" do
      attribute_review = attribute_review_fixture()

      assert Companies.get_attribute_review!(attribute_review.id) ==
               attribute_review
    end

    test "create_attribute_review/1 with valid data creates a attribute_review" do
      assert {:ok, %AttributeReview{} = attribute_review} =
               Companies.create_attribute_review(@valid_attrs)

      assert attribute_review.score == 42
    end

    test "create_attribute_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Companies.create_attribute_review(@invalid_attrs)
    end

    test "update_attribute_review/2 with valid data updates the attribute_review" do
      attribute_review = attribute_review_fixture()

      assert {:ok, attribute_review} =
               Companies.update_attribute_review(
                 attribute_review,
                 @update_attrs
               )

      assert %AttributeReview{} = attribute_review
      assert attribute_review.score == 43
    end

    test "update_attribute_review/2 with invalid data returns error changeset" do
      attribute_review = attribute_review_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Companies.update_attribute_review(
                 attribute_review,
                 @invalid_attrs
               )

      assert attribute_review ==
               Companies.get_attribute_review!(attribute_review.id)
    end

    test "delete_attribute_review/1 deletes the attribute_review" do
      attribute_review = attribute_review_fixture()

      assert {:ok, %AttributeReview{}} =
               Companies.delete_attribute_review(attribute_review)

      assert_raise Ecto.NoResultsError, fn ->
        Companies.get_attribute_review!(attribute_review.id)
      end
    end

    test "change_attribute_review/1 returns a attribute_review changeset" do
      attribute_review = attribute_review_fixture()

      assert %Ecto.Changeset{} =
               Companies.change_attribute_review(attribute_review)
    end
  end
end
