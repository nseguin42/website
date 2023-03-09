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
        timestamp: ~N[2023-03-08 01:44:00]
      })
      |> Ns.Version.create_commit()

    commit
  end

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
        timestamp: ~N[2023-03-08 02:21:00],
        url: "some url"
      })
      |> Ns.Version.create_commit()

    commit
  end

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
        timestamp: ~N[2023-03-08 02:23:00],
        url: "some url"
      })
      |> Ns.Version.create_commit()

    commit
  end

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
        timestamp: ~N[2023-03-08 02:28:00],
        url: "some url"
      })
      |> Ns.Version.create_commit()

    commit
  end
end
