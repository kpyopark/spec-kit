# Changelog

All notable changes to the Specify CLI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.12] - 2025-10-12

### Fixed

- Fixed slash commands not appearing in Claude Code by moving command files from `.specify/templates/commands/` to `.claude/commands/` in the template packages. Commands now properly install to the correct location where Claude Code looks for them.

### Changed

- Updated build-packages.sh to copy command definitions to `.claude/commands/` directory

## [0.0.7] - 2025-09-18

### Changed

- Updated command instructions in the CLI.
- Cleaned up the code to not render agent-specific information when it's generic.


## [0.0.6] - 2025-09-17

### Added

- opencode support as additional AI assistant option

## [0.0.5] - 2025-09-17

### Added

- Qwen Code support as additional AI assistant option

## [0.0.4] - 2025-09-14

### Added

- SOCKS proxy support for corporate environments via `httpx[socks]` dependency

### Fixed

N/A

### Changed

N/A

