import {Octokit} from '@octokit/core';

const octokit = new Octokit();

export const getGithubUrl = (owner, repo, commit) => {
  const baseUrl = `https://github.com/${owner}/${repo}`;
  return commit ? `${baseUrl}/commit/${commit}` : baseUrl;
};

export const getCommitMessage = (owner, repo, commit) => {
  return octokit
    .request('GET /repos/{owner}/{repo}/commits/{commit}', {
      owner,
      repo,
      commit
    })
    .then((result) => result.data.commit.message.split('\n')[0]);
};
