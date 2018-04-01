defmodule DiversityInTechWeb.LayoutView do
  use DiversityInTechWeb, :view

  def options_for(enum) do
    enum.__enum_map__
    |> Keyword.keys()
    |> Enum.sort()
    |> Enum.map(&{&1, &1})
  end
end
