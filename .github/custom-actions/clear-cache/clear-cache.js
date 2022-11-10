const { Octokit } = require('@octokit/core');

const octokit = new Octokit({
    auth: process.env.GITHUB_AUTH_TOKEN
});

const OWNER = 'leandro-mancini';
const REPO = 'flutter-rick-and-morty';

async function run() {
    console.log(process.env.GITHUB_AUTH_TOKEN);

    try {
        await getCaches()
            .then(caches => console.log(caches));
    } catch (e) {
        throw new Error(`Erro ao realizar a limpeza dos caches, ${e}`);
    }
}

async function getCaches() {
    console.log(OWNER);
    console.log(REPO);

    const { data } = await octokit.request('GET /repos/{owner}/{repo}/actions/caches', {
        owner: OWNER,
        repo: REPO
    });

    return data.actions_caches;
}


run();