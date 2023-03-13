defmodule NsWeb.Markdown do
  @moduledoc """
  Converts markdown to HTML.
  """

  defmodule Options do
    defstruct [:class, earmark_options: Earmark.Options]

    def get do
      opts = Application.get_env(:ns_web, :markdown)
      class = Map.get(opts, :class)
      earmark_options = Map.get(opts, :earmark)

      %Options{
        class: class,
        earmark_options: parse_earmark_options(earmark_options)
      }
    end

    defp parse_earmark_options(opts) do
      Kernel.struct(Earmark.Options, opts)
    end
  end

  @doc """
  Converts the given markdown to HTML.
  """
  def as_html(markdown) do
    opts = Options.get()
    as_html(markdown, opts)
  end

  @doc """
  Converts the given markdown to HTML.
  """
  def as_html(markdown, opts) do
    markdown
    |> Earmark.as_html!(opts.earmark_options)
    |> envelope(opts.class)
  end

  defp envelope(body, class) do
    if class == nil do
      body
    else
      """
      <div class="#{class}">
        #{body}
      </div>
      """
    end
  end

  defmodule Engine do
    @behaviour Phoenix.Template.Engine

    def compile(path, _name) do
      path
      |> File.read!()
      |> NsWeb.Markdown.as_html()
      |> EEx.compile_string(engine: Phoenix.HTML.Engine, file: path, line: 1)
    end
  end
end
