defmodule NsWeb.Api.ApiController do
  use NsWeb, :controller

  def get_commit(conn, _params) do
    case File.read("commit.txt") do
      {:ok, commit} ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, commit)

      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(502, "unknown")
    end
  end

  def post_commit(conn, _params) do
    Jason.decode("{}")
    |> case do
      {:ok, commitJson} ->
        File.write("commit.txt", "{}")
        |> case do
          :ok ->
            conn
            |> put_resp_content_type("text/plain")
            |> send_resp(200, "updated to latest commit")

          _ ->
            conn
            |> put_resp_content_type("text/plain")
            |> send_resp(502, "failed to save commit.txt")
        end

      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(502, "failed to parse json")
    end
  end
end
