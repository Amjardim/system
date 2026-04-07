# Noma-Travel migration — status and next steps

## Pushed in this session

These branches were pushed to `Noma-Travel` (from local `main_noma`):

| Local path | Remote | Branch pushed |
|------------|--------|----------------|
| `C:/Noma/dev/renglo-api` | `https://github.com/Noma-Travel/renglo-api.git` | `main_noma` → remote `main` |
| `C:/Noma/system` | `https://github.com/Noma-Travel/system.git` | `main_noma` → remote `main` |
| `C:/Noma/console` | `origin` (`https://github.com/Noma-Travel/console.git`) | `main_noma` |

Remote name `noma-travel` was added on `renglo-api` and `system` for pushes; adjust `origin` when you want the workspace to track only Noma-Travel.

## Still required for `pip install -r requirements.txt`

[`requirements-noma-travel.txt`](requirements-noma-travel.txt) expects these repos to exist on GitHub with a `main` branch (or change the `@main` pins to your branch):

- `Noma-Travel/renglo-lib`
- `Noma-Travel/renglo-api` (done)
- `Noma-Travel/noma-handlers`
- `Noma-Travel/pes`
- `Noma-Travel/pes_noma`

Mirror each from the current `renglo` (or local) source, then confirm:

```bash
cd C:/Noma/system
# activate venv
pip install -r requirements.txt
./zappa_update.sh noma_prod update
```

Until all five exist, use `pip install -r requirements-local.txt` before `./zappa_update.sh`.

## Point `origin` only at Noma-Travel (optional)

Per repo (example for API):

```bash
git remote remove renglo   # if present
git remote set-url origin https://github.com/Noma-Travel/renglo-api.git
git fetch origin
git branch --set-upstream-to=origin/main_noma main_noma
```

Use the same pattern for `renglo-lib`, `noma-handlers`, `pes`, and `pes_noma` clones.
