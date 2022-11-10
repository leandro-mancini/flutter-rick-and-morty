const { Octokit } = require('@octokit/core');

const octokit = new Octokit({
    auth: 'ghp_l46xXXjs0hynQtUEE5Xgwg3AO8tfuY4QkADl'
});

const OWNER = 'leandro-mancini';
const REPO = 'flutter-rick-and-morty';

async function run() {
    try {
        await getCaches()
            .then(caches => console.log(caches));
    } catch (e) {
        throw new Error(`Erro ao realizar a limpeza dos caches, ${e}`);
    }
}

async function getCaches() {
    const { data } = await octokit.request('GET /repos/{owner}/{repo}/actions/caches', {
        owner: OWNER,
        repo: REPO
    });

    return data.actions_caches;
}


run();