defmodule DiversityInTech.Uploaders.Image do
  @moduledoc """
  DiversityInTech.Uploaders.Image module.
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png .svg .tif .bmp)
    |> Enum.member?(Path.extname(file.file_name))
  end

  def transform(:thumb, _) do
    {:convert,
     "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png",
     :png}
  end

  def default_url(_version, _scope), do: ""

  def storage_dir(version, {_file, scope}) do
    "priv/uploads/images/#{scope.id}/#{version}"
  end
end
