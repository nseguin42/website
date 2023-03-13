defmodule NsWeb.LaTeX do
  @moduledoc """
  Converts LaTeX to HTML.
  """

  @doc """
  Converts the given LaTeX string to HTML.
  """
  def as_html(string) do
    tmp_dir = setup_tmp_dir("inline")

    html =
      string
      |> to_inline_tex()
      |> write_tex_to_tmp(tmp_dir)
      |> convert_tex_to_html("latex/inline.css")

    teardown_tmp_dir(tmp_dir)
    html
  end

  @doc """
  Converts the given .tex file to HTML.
  """
  def convert_tex_to_html(path, css \\ "latex/base.css") do
    tmp_dir = setup_tmp_dir(path)

    html =
      path
      |> convert_tex_to_xml(tmp_dir)
      |> convert_xml_to_html(tmp_dir, css)
      |> File.read!()

    teardown_tmp_dir(tmp_dir)
    html
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

  defp convert_tex_to_xml(path, tmp_dir) do
    basename = Path.basename(path, ".tex")
    output_path = Path.join(tmp_dir, "#{basename}.xml")

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

  defp write_tex_to_tmp(string, tmp_dir) do
    path = Path.join(tmp_dir, "tmp.tex")
    File.write!(path, string)
    path
  end

  defp setup_tmp_dir(path) do
    salt = :crypto.strong_rand_bytes(16) |> Base.encode16() |> String.slice(0..7)

    tmp_dir =
      System.tmp_dir!()
      |> Path.join("ns_web")
      |> Path.join("latex")
      |> Path.join(Path.basename(path) <> "-" <> salt)

    File.mkdir_p!(tmp_dir)
    tmp_dir
  end

  defp teardown_tmp_dir(tmp_dir) do
    File.rm_rf!(tmp_dir)
  end

  defp convert_xml_to_html(path, tmp_dir, css) do
    output_path = Path.join(tmp_dir, "index.html")

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
      |> NsWeb.LaTeX.convert_tex_to_html()
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
