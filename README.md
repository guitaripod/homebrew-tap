# guitaripod Homebrew Tap

This is a Homebrew tap for installing tools created by @guitaripod.

## How to use

```bash
brew tap guitaripod/tap
brew install speedrun-cli
# or
brew install pomme
# or
brew install starcraft-cli
```

## Available Formulae

- **speedrun-cli** - Browse speedrun.com leaderboards from your terminal
- **pomme** - A powerful CLI tool for App Store Connect analytics, sales reports, and app management. [GitHub](https://github.com/guitaripod/pomme)
- **starcraft-cli** - Command-line tool for tracking StarCraft 2 esports. [GitHub](https://github.com/guitaripod/StarCraftKit)

## Services

`claude-bridge` (prebuilt, Apple silicon) and `delegate` are signed under a fixed identity, so macOS keeps a firewall or privacy permission across `brew upgrade`.

```bash
brew install claude-bridge delegate
brew services start claude-bridge
claude-bridge pair
```
