defmodule NsWeb.LaTeX do
  @moduledoc """
  Converts LaTeX to HTML.
  """

  import Logger

  @doc """
  Converts the given LaTeX string to HTML.
  """
  def as_html(string) do
    hash = get_hash(string)
    cache_file = Path.join(target_dir(), "#{hash}/index.html")

    case File.read(cache_file) do
      {:ok, html} ->
        html

      {:error, :enoent} ->
        convert_string_to_html(string)
        |> cache_then_get(cache_file)

      _ ->
        raise "Could not read #{cache_file}"
    end
  end

  @doc """
  Converts the given .tex file to HTML.
  """
  def get_html_from_tex_file(path) do
    hash = get_hash(path |> Path.basename())
    cache_file = Path.join(target_dir(), "#{hash}/index.html")

    case File.read(cache_file) do
      {:ok, html} ->
        html

      {:error, :enoent} ->
        convert_tex_to_html(path)
        |> cache_then_get(cache_file)

      _ ->
        raise "Could not read #{cache_file}"
    end
  end

  defp cache_then_get(html, cache_file) do
    Logger.info("Saving LaTeX to cache: #{cache_file}")
    File.mkdir_p!(Path.dirname(cache_file))
    File.write!(cache_file, html)
    html
  end

  defp convert_tex_to_html(path, css \\ "latex/base.css") do
    dir = target_dir()
    hash = get_hash(path |> Path.basename())

    html =
      path
      |> convert_tex_to_xml(hash)
      |> convert_xml_to_html(css)
      |> File.read!()

    html
  end

  defp convert_string_to_html(string, css \\ "latex/base.css") do
    string
    |> to_inline_tex()
    |> write_tex_to_file()
    |> convert_tex_to_html(css)
  end

  defp target_dir do
    Application.app_dir(:ns_web) |> Path.join("latex")
  end

  defp get_hash(string) do
    :crypto.hash(:md5, string) |> Base.encode16() |> String.slice(0..15)
  end

  defp to_inline_tex(string) do
    ~s"""
    \\documentclass{article}
    \\usepackage{amsmath}
    \\usepackage{graphicx}

    \\begin{document}
    #{string}
    \\end{document}
    """
  end

  defp convert_tex_to_xml(path, hash) do
    dir = target_dir()
    output_path = Path.join(dir, "#{hash}/index.xml")

    command =
      ~s"""
        latexmlc "#{path}"
        --destination="#{output_path}"
        --quiet
        --nocomments
      """
      |> String.replace("\n", " ")
      |> String.trim()

    result = System.cmd("sh", ["-c", command])

    case result do
      {_, 0} -> output_path
      {_, _} -> raise "LaTeXML failed to compile #{path}"
    end
  end

  defp write_tex_to_file(string) do
    hash = get_hash(string)
    dir = Path.join(target_dir(), hash)
    File.mkdir_p!(dir)

    path = Path.join(dir, "index.tex")
    File.write!(path, string)
    path
  end

  defp convert_xml_to_html(path, css) do
    dir = Path.dirname(path)
    output_path = Path.join(dir, "index.html")

    command =
      ~s"""
      latexmlpost "#{path}"
      --format=html5
      --destination="#{output_path}"
      --nodefaultresources
      --javascript="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js?config=MML
      _HTMLorMML"
      --css=#{css}
      --svg
      --quiet
      """
      |> String.replace("\n", " ")
      |> String.trim()

    result = System.cmd("sh", ["-c", command])

    case result do
      {_, 0} -> output_path
      {_, _} -> raise "LaTeXML failed to compile #{path}"
    end
  end

  defmodule Engine do
    @behaviour Phoenix.Template.Engine

    def compile(path, _name) do
      path
      |> NsWeb.LaTeX.get_html_from_tex_file()
      |> EEx.compile_string(engine: Phoenix.HTML.Engine, file: path, line: 1)
    end
  end

  defmodule Sigils do
    @moduledoc """
    Provides the `~L` sigil for converting LaTeX to HTML.
    """

    @doc """
    Converts the given LaTeX string to HTML.
    """
    def sigil_L(string, _opts) do
      NsWeb.LaTeX.as_html(string)
    end
  end
end
