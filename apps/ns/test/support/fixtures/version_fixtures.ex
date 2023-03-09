defmodule Ns.VersionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ns.Version` context.
  """

  @doc """
  Generate a commit.
  """
  def commit_fixture(attrs \\ %{}) do
    {:ok, commit} =
      attrs
      |> Enum.into(%{
        author: "some author",
        message: "some message",
        sha: "some sha",
        timestamp: ~N[2023-03-08 01:44:00],
        url: "http://example.com"
      })
      |> Ns.Version.create_commit()

    commit
  end
end
