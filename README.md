# ✨ slay

A deployment monitoring and developer workflow CLI with personality.

She watches. She waits. She **slays**.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/dblumenau/slay/main/install.sh | bash
```

Or with a custom install directory:

```bash
SLAY_INSTALL_DIR=/usr/local/bin curl -fsSL https://raw.githubusercontent.com/dblumenau/slay/main/install.sh | bash
```

### Dependencies

```bash
brew install gum fd curl
```

## Usage

### Interactive Mode

```bash
slay
```

Pick a project, then choose an action:
- **Watch for new tag** — Monitor a deployment for version changes
- **Sync to master** — Stash, switch branch, pull (hotfix-ready in seconds)
- **Composer install** — Run composer install with correct PHP version
- **npm install** — Run npm install with correct Node version
- **Run schedule** — Run artisan schedule:run (background + notification)
- **Open in VSCode/PhpStorm** — Open project in your editor

### Direct Mode

```bash
slay https://staging.example.com/healthz 1.2.3
```

Watch for version `1.2.3` to appear at the health endpoint.

### Options

```
-i, --interval <seconds>    Time between checks (default: 30s)
-r, --refresh               Rebuild the project cache
-h, --help                  Show help
-v, --version               Show version
```

## Configuration

### Projects Directory

By default, slay looks for projects in `~/projects`. Override with:

```bash
# Environment variable
export SLAY_PROJECTS_DIR="$HOME/code"

# Or in config file
echo 'PROJECTS_DIR="$HOME/code"' >> ~/.config/slay/config
```

### URL Auto-Discovery (Optional)

Slay can auto-discover health endpoint URLs from your project files. Create a discovery script:

```bash
# Copy an example
cp ~/.local/bin/slay-lib/examples/discover-deployment-yaml.sh ~/.config/slay/discover-urls.sh
chmod +x ~/.config/slay/discover-urls.sh

# Enable it
mkdir -p ~/.config/slay
echo 'URL_DISCOVERY_SCRIPT="$HOME/.config/slay/discover-urls.sh"' >> ~/.config/slay/config
```

See `slay-lib/examples/` for discovery scripts for:
- Kubernetes `deployment.yaml` with `APP_URL`
- Docker Compose with `HEALTH_URL`
- `.env` files with `APP_URL`

Or write your own — just output `project_group|url` pairs.

## The Fine Print

- Polls every 30s by default (or your `-i` vibe)
- When version matches, waits 3s and double-checks (no flicker drama)
- Auto-exits after 10 min (no zombie processes in THIS house)
- Sends push notification when complete (if `notify-watch` is available)

## License

MIT
