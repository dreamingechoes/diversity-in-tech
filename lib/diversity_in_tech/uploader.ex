defmodule DiversityInTech.Uploader do
  @moduledoc """
  Provides useful functions used by all application uploaders.
  """

  def file_path(resource, file, uploader) do
    {file, resource}
    |> uploader.url
    |> String.split("?")
    |> List.first()
    |> String.split("/")
    |> Enum.at(-1)
    |> URI.decode()
  end
end
