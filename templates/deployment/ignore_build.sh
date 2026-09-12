#!/usr/bin/env bash
#
# Deployment "Ignored Build Step" (stack-agnostic template).
#   exit 0  -> SKIP the build (no deploy, no build minutes)
#   exit 1  -> PROCEED with the build
#
# Rule: only build when the commit changed something that can affect the built
# bundle. Docs-only / process / .kiro / CI-config-meta changes are skipped.
#
# Fail-safe by design: APP_PATHS is an ALLOWLIST of bundle-affecting paths (build
# if any changed). Anything unknown/unanticipated falls through to BUILD (a wasted
# build at worst) — never to a silent SKIP of a real change (which would ship stale).
#
# Wire it up:
#   - Vercel:  vercel.json  ->  "ignoreCommand": "chmod +x ./ignore_build.sh && ./ignore_build.sh"
#   - Netlify: netlify.toml ->  [build] ignore = "bash ignore_build.sh"
# The host runs this from the repo root with HEAD = the commit being considered.
#
# EDIT the APP_PATHS list below for your stack before using. Examples:
#   Vite/React:  src/ public/ index.html package.json package-lock.json vite.config.ts tsconfig.json vercel.json
#   Flutter web: lib/ web/ pubspec.yaml pubspec.lock l10n.yaml analysis_options.yaml vercel.json
#   Next.js:     app/ src/ public/ package.json package-lock.json next.config.js vercel.json

set -euo pipefail

# Paths whose changes DO affect the built app bundle. EDIT FOR YOUR STACK.
APP_PATHS=(
  src/                    # application source
  public/                 # static assets bundled into the app
  package.json            # deps + scripts
  package-lock.json       # resolved deps (use yarn.lock / pnpm-lock.yaml as appropriate)
  vercel.json             # build/deploy config itself
  # add build/codegen/lint config that can fail or change the build, e.g.:
  # vite.config.ts tsconfig.json index.html
)

# Compare the deploy commit against its parent. If any app path changed -> build.
if git diff --quiet "HEAD^" "HEAD" -- "${APP_PATHS[@]}" 2>/dev/null; then
  echo "🟡 Deploy: no bundle-affecting changes in this commit — SKIPPING build."
  exit 0
else
  echo "🟢 Deploy: bundle-affecting changes detected — proceeding with build."
  exit 1
fi
