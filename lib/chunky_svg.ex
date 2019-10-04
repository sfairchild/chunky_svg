defmodule ChunkySVG do
  def render(drawing) when is_tuple(drawing), do: render([drawing], %{})
  def render(drawing, svg_options) when is_tuple(drawing), do: render([drawing], svg_options)
  def render(drawing), do: render(drawing, %{})

  def render(drawing, svg_options) when is_list(drawing) and is_map(svg_options) do
    svg_options = %{viewBox: "0 0 100 100", xmlns: "http://www.w3.org/2000/svg"}
                  |> Map.merge(svg_options)
    drawing = drawing |>
      ChunkySVG.Builtin.expand |>
      ChunkySVG.InlineMacro.expand
    { :svg, svg_options, drawing } |> XmlBuilder.generate
  end
end
