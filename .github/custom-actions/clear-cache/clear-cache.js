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
            .then(caches => caches.length > 0 ? caches.map(cache => cache.id) : null)
            .then(ids => ids.map(id => deleteCache(id)));
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

async function deleteCache(id) {
    try {
        console.log(`Deletando cache com id: ${id}`);

        return octokit.request('DELETE /repos/{owner}/{repo}/actions/caches/{cache_id}', {
            owner: OWNER,
            repo: REPO,
            cache_id: id
        });
    } catch (e) {
        throw new Error(`Ocorreu um erro na deleção do cache, ${e}`);
    }
}


run();