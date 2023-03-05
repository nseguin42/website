defmodule NsWeb.PageControllerTest do
  use NsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "<!DOCTYPE html>"
  end
end
