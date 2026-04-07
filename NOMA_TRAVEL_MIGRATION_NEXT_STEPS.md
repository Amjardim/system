# Noma-Travel migration — status and next steps

## Pushed in this session

These branches were pushed to `Noma-Travel`:

| Local path | Remote | Branch pushed |
|------------|--------|----------------|
| `C:/Noma/dev/renglo-api` | `https://github.com/Noma-Travel/renglo-api.git` | `main_noma` -> remote `main` |
| `C:/Noma/system` | `https://github.com/Noma-Travel/system.git` | `main_noma` -> remote `main` |
| `C:/Noma/console` | `https://github.com/Noma-Travel/console.git` | `main_noma` |
| `C:/Noma/dev/renglo-lib` | `https://github.com/Noma-Travel/renglo-lib.git` | `main_noma` -> `noma_migration_sync_main_noma` |
| `C:/Noma/extensions/pes_noma` | `https://github.com/Noma-Travel/pes_noma.git` | `main` -> `noma_migration_sync_main` |

## Current blockers

- `https://github.com/Noma-Travel/noma-handlers.git` does not exist yet (GitHub: repository not found).
- `pes` migration was intentionally skipped for now.
- `Noma-Travel/renglo-lib` default branch is `main_noma` (not `main`), so requirements were updated accordingly.

## Active install mode

`requirements.txt` now points to a hybrid set in `requirements-noma-travel.txt`:
- Noma-Travel git installs where available (`renglo-lib`, `renglo-api`, `pes_noma`)
- local fallback for missing/skipped repos (`../extensions/noma/package`, `../extensions/pes/package`)

This keeps backend deployment runnable while migration completes.

## Complete migration checklist

1. Create `Noma-Travel/noma-handlers` and push `extensions/noma` there.
2. If needed later, create `Noma-Travel/pes` and push `extensions/pes` there.
3. Replace local fallback lines in `requirements-noma-travel.txt` with git URLs.
4. Re-run:

```bash
cd C:/Noma/system
# activate venv
pip install -r requirements.txt
./zappa_update.sh noma_prod update
```

## Workspace remotes policy

The following repos now use Noma-Travel as `origin`:
- `renglo-api`
- `renglo-lib`
- `console`
- `system`
- `pes_noma`

`extensions/noma` and `extensions/pes` remain on `renglo` origin until destination repos are created/approved.
