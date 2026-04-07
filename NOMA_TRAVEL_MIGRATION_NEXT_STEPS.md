# Noma-Travel migration ? status and next steps

## Canonical handler repo

The former `renglo/noma` extension is tracked under **`Noma-Travel/noma_handlers`**:  
[https://github.com/Noma-Travel/noma_handlers](https://github.com/Noma-Travel/noma_handlers)

Local clone: `C:/Noma/extensions/noma` ? `origin` should be `https://github.com/Noma-Travel/noma_handlers.git`.

If your local `main` diverges from `origin/main` (many commits ahead/behind), reconcile with fetch/merge or rebase before pushing.

## `pes` (still upstream `renglo`)

`Noma-Travel/pes` does not exist yet. [`requirements-noma-travel.txt`](requirements-noma-travel.txt) uses local `../extensions/pes/package` until that repo is created.

## Requirements install

- [`requirements-noma-travel.txt`](requirements-noma-travel.txt) installs `noma-mod` from `noma_handlers` via `git+...&subdirectory=package`.
- `renglo-lib` uses branch `main_noma` on GitHub (not `main`).

```bash
cd C:/Noma/system
# activate venv
pip install -r requirements.txt
./zappa_update.sh noma_prod update
```

## Workspace remotes

See [`WORKSPACE_GITHUB_ORIGINS.md`](WORKSPACE_GITHUB_ORIGINS.md) for a full table of `origin` URLs.
