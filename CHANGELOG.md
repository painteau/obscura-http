# Changelog

## [Unreleased]

### Added
- `LICENSE.md`: BZ-1.1 (BREIZHZION Personal Use License), the licence of every public repository of
  the fleet; the repository was public without any licence.

## [1.0.1] - 2026-11-22

### Security
- `apt-get upgrade` at build time so the image ships `libbrotli1` 1.1.0-2ubuntu0.1
  (CVE-2026-111497, USN-8956-1), also used by the Ubuntu Node.js; the build now fails
  if `libbrotli1` is older.

### Changed
- The image is published only on a `vX.Y.Z` tag or a manual run; a push to `main`
  only checks that it builds.

## [1.0.0] - 2026-05-22

### Added
- HTTP wrapper around the obscura CDP server: `POST /html` returns `{"html": ...}`.
