defmodule Ns.VersionTest do
  use Ns.DataCase

  alias Ns.Version

  describe "commits" do
    alias Ns.Version.Commit

    import Ns.VersionFixtures

    @invalid_attrs %{author: nil, message: nil, sha: nil, timestamp: nil}

    test "list_commits/0 returns all commits" do
      commit = commit_fixture()
      assert Version.list_commits() == [commit]
    end

    test "get_commit!/1 returns the commit with given id" do
      commit = commit_fixture()
      assert Version.get_commit!(commit.id) == commit
    end

    test "create_commit/1 with valid data creates a commit" do
      valid_attrs = %{
        author: "some author",
        message: "some message",
        sha: "some sha",
        timestamp: ~N[2023-03-08 01:44:00]
      }

      assert {:ok, %Commit{} = commit} = Version.create_commit(valid_attrs)
      assert commit.author == "some author"
      assert commit.message == "some message"
      assert commit.sha == "some sha"
      assert commit.timestamp == ~N[2023-03-08 01:44:00]
    end

    test "create_commit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Version.create_commit(@invalid_attrs)
    end

    test "update_commit/2 with valid data updates the commit" do
      commit = commit_fixture()

      update_attrs = %{
        author: "some updated author",
        message: "some updated message",
        sha: "some updated sha",
        timestamp: ~N[2023-03-09 01:44:00]
      }

      assert {:ok, %Commit{} = commit} = Version.update_commit(commit, update_attrs)
      assert commit.author == "some updated author"
      assert commit.message == "some updated message"
      assert commit.sha == "some updated sha"
      assert commit.timestamp == ~N[2023-03-09 01:44:00]
    end

    test "update_commit/2 with invalid data returns error changeset" do
      commit = commit_fixture()
      assert {:error, %Ecto.Changeset{}} = Version.update_commit(commit, @invalid_attrs)
      assert commit == Version.get_commit!(commit.id)
    end

    test "delete_commit/1 deletes the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{}} = Version.delete_commit(commit)
      assert_raise Ecto.NoResultsError, fn -> Version.get_commit!(commit.id) end
    end

    test "change_commit/1 returns a commit changeset" do
      commit = commit_fixture()
      assert %Ecto.Changeset{} = Version.change_commit(commit)
    end
  end

  describe "commits" do
    alias Ns.Version.Commit

    import Ns.VersionFixtures

    @invalid_attrs %{author: nil, message: nil, sha: nil, timestamp: nil, url: nil}

    test "list_commits/0 returns all commits" do
      commit = commit_fixture()
      assert Version.list_commits() == [commit]
    end

    test "get_commit!/1 returns the commit with given id" do
      commit = commit_fixture()
      assert Version.get_commit!(commit.id) == commit
    end

    test "create_commit/1 with valid data creates a commit" do
      valid_attrs = %{
        author: "some author",
        message: "some message",
        sha: "some sha",
        timestamp: ~N[2023-03-08 02:21:00],
        url: "some url"
      }

      assert {:ok, %Commit{} = commit} = Version.create_commit(valid_attrs)
      assert commit.author == "some author"
      assert commit.message == "some message"
      assert commit.sha == "some sha"
      assert commit.timestamp == ~N[2023-03-08 02:21:00]
      assert commit.url == "some url"
    end

    test "create_commit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Version.create_commit(@invalid_attrs)
    end

    test "update_commit/2 with valid data updates the commit" do
      commit = commit_fixture()

      update_attrs = %{
        author: "some updated author",
        message: "some updated message",
        sha: "some updated sha",
        timestamp: ~N[2023-03-09 02:21:00],
        url: "some updated url"
      }

      assert {:ok, %Commit{} = commit} = Version.update_commit(commit, update_attrs)
      assert commit.author == "some updated author"
      assert commit.message == "some updated message"
      assert commit.sha == "some updated sha"
      assert commit.timestamp == ~N[2023-03-09 02:21:00]
      assert commit.url == "some updated url"
    end

    test "update_commit/2 with invalid data returns error changeset" do
      commit = commit_fixture()
      assert {:error, %Ecto.Changeset{}} = Version.update_commit(commit, @invalid_attrs)
      assert commit == Version.get_commit!(commit.id)
    end

    test "delete_commit/1 deletes the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{}} = Version.delete_commit(commit)
      assert_raise Ecto.NoResultsError, fn -> Version.get_commit!(commit.id) end
    end

    test "change_commit/1 returns a commit changeset" do
      commit = commit_fixture()
      assert %Ecto.Changeset{} = Version.change_commit(commit)
    end
  end

  describe "commits" do
    alias Ns.Version.Commit

    import Ns.VersionFixtures

    @invalid_attrs %{author: nil, message: nil, sha: nil, timestamp: nil, url: nil}

    test "list_commits/0 returns all commits" do
      commit = commit_fixture()
      assert Version.list_commits() == [commit]
    end

    test "get_commit!/1 returns the commit with given id" do
      commit = commit_fixture()
      assert Version.get_commit!(commit.id) == commit
    end

    test "create_commit/1 with valid data creates a commit" do
      valid_attrs = %{
        author: "some author",
        message: "some message",
        sha: "some sha",
        timestamp: ~N[2023-03-08 02:23:00],
        url: "some url"
      }

      assert {:ok, %Commit{} = commit} = Version.create_commit(valid_attrs)
      assert commit.author == "some author"
      assert commit.message == "some message"
      assert commit.sha == "some sha"
      assert commit.timestamp == ~N[2023-03-08 02:23:00]
      assert commit.url == "some url"
    end

    test "create_commit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Version.create_commit(@invalid_attrs)
    end

    test "update_commit/2 with valid data updates the commit" do
      commit = commit_fixture()

      update_attrs = %{
        author: "some updated author",
        message: "some updated message",
        sha: "some updated sha",
        timestamp: ~N[2023-03-09 02:23:00],
        url: "some updated url"
      }

      assert {:ok, %Commit{} = commit} = Version.update_commit(commit, update_attrs)
      assert commit.author == "some updated author"
      assert commit.message == "some updated message"
      assert commit.sha == "some updated sha"
      assert commit.timestamp == ~N[2023-03-09 02:23:00]
      assert commit.url == "some updated url"
    end

    test "update_commit/2 with invalid data returns error changeset" do
      commit = commit_fixture()
      assert {:error, %Ecto.Changeset{}} = Version.update_commit(commit, @invalid_attrs)
      assert commit == Version.get_commit!(commit.id)
    end

    test "delete_commit/1 deletes the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{}} = Version.delete_commit(commit)
      assert_raise Ecto.NoResultsError, fn -> Version.get_commit!(commit.id) end
    end

    test "change_commit/1 returns a commit changeset" do
      commit = commit_fixture()
      assert %Ecto.Changeset{} = Version.change_commit(commit)
    end
  end

  describe "commits" do
    alias Ns.Version.Commit

    import Ns.VersionFixtures

    @invalid_attrs %{author: nil, message: nil, sha: nil, timestamp: nil, url: nil}

    test "list_commits/0 returns all commits" do
      commit = commit_fixture()
      assert Version.list_commits() == [commit]
    end

    test "get_commit!/1 returns the commit with given id" do
      commit = commit_fixture()
      assert Version.get_commit!(commit.id) == commit
    end

    test "create_commit/1 with valid data creates a commit" do
      valid_attrs = %{
        author: "some author",
        message: "some message",
        sha: "some sha",
        timestamp: ~N[2023-03-08 02:28:00],
        url: "some url"
      }

      assert {:ok, %Commit{} = commit} = Version.create_commit(valid_attrs)
      assert commit.author == "some author"
      assert commit.message == "some message"
      assert commit.sha == "some sha"
      assert commit.timestamp == ~N[2023-03-08 02:28:00]
      assert commit.url == "some url"
    end

    test "create_commit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Version.create_commit(@invalid_attrs)
    end

    test "update_commit/2 with valid data updates the commit" do
      commit = commit_fixture()

      update_attrs = %{
        author: "some updated author",
        message: "some updated message",
        sha: "some updated sha",
        timestamp: ~N[2023-03-09 02:28:00],
        url: "some updated url"
      }

      assert {:ok, %Commit{} = commit} = Version.update_commit(commit, update_attrs)
      assert commit.author == "some updated author"
      assert commit.message == "some updated message"
      assert commit.sha == "some updated sha"
      assert commit.timestamp == ~N[2023-03-09 02:28:00]
      assert commit.url == "some updated url"
    end

    test "update_commit/2 with invalid data returns error changeset" do
      commit = commit_fixture()
      assert {:error, %Ecto.Changeset{}} = Version.update_commit(commit, @invalid_attrs)
      assert commit == Version.get_commit!(commit.id)
    end

    test "delete_commit/1 deletes the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{}} = Version.delete_commit(commit)
      assert_raise Ecto.NoResultsError, fn -> Version.get_commit!(commit.id) end
    end

    test "change_commit/1 returns a commit changeset" do
      commit = commit_fixture()
      assert %Ecto.Changeset{} = Version.change_commit(commit)
    end
  end
end
