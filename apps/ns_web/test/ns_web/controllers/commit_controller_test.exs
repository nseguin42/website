defmodule NsWeb.CommitControllerTest do
  use NsWeb.ConnCase

  import Ns.VersionFixtures

  alias Ns.Version.Commit

  @create_attrs %{
    author: "some author",
    message: "some message",
    sha: "some sha",
    timestamp: ~N[2023-03-08 02:28:00],
    url: "some url"
  }
  @update_attrs %{
    author: "some updated author",
    message: "some updated message",
    sha: "some updated sha",
    timestamp: ~N[2023-03-09 02:28:00],
    url: "some updated url"
  }
  @invalid_attrs %{author: nil, message: nil, sha: nil, timestamp: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all commits", %{conn: conn} do
      conn = get(conn, ~p"/api/commits")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create commit" do
    test "renders commit when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/commits", commit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/commits/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "message" => "some message",
               "sha" => "some sha",
               "timestamp" => "2023-03-08T02:28:00",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/commits", commit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update commit" do
    setup [:create_commit]

    test "renders commit when data is valid", %{conn: conn, commit: %Commit{id: id} = commit} do
      conn = put(conn, ~p"/api/commits/#{commit}", commit: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/commits/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "message" => "some updated message",
               "sha" => "some updated sha",
               "timestamp" => "2023-03-09T02:28:00",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, commit: commit} do
      conn = put(conn, ~p"/api/commits/#{commit}", commit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete commit" do
    setup [:create_commit]

    test "deletes chosen commit", %{conn: conn, commit: commit} do
      conn = delete(conn, ~p"/api/commits/#{commit}")
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, ~p"/api/commits/#{commit}")
      end)
    end
  end

  defp create_commit(_) do
    commit = commit_fixture()
    %{commit: commit}
  end
end
