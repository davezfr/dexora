# Dexora

> Limited beta notice: Dexora is an unofficial small-group TestFlight beta fork for learning, personal use, and self-hosted experimentation. It is not an official OpenAI, Codex, Apple, or Remodex app, and it is not planned as a public commercial App Store release. For a maintained and stable product experience, please support the original Remodex project/app.

Dexora is a self-hosted iPhone companion for controlling a coding agent running on your own computer.

This fork is prepared for small-group TestFlight beta testing. It is not an official OpenAI, Codex, Apple, or Remodex app. It is built from the open-source Remodex project under the Apache 2.0 license, with a new app name, icon, bundle ID, and beta review path.

Expect bugs. Dexora is for learning, personal use, and invited testing.

## What Dexora Does

Dexora lets your iPhone act as a remote interface for a computer-side coding agent.

The iPhone app can:

- send prompts to the agent running on your paired computer
- display streaming responses
- attach images from camera or photo library
- record voice input for transcription
- show chats, projects, branches, and worktrees
- trigger selected git and worktree actions
- reconnect to a trusted computer after the first QR pairing
- open an offline demo for Apple review or first-look testing

Dexora does not run the coding agent on the phone. Your computer remains the place where model access, terminal commands, file edits, git operations, credentials, and repositories live.

## Current Beta Boundary

This build is intentionally small:

- no Dexora account system
- no in-app purchases
- no StoreKit flow
- no RevenueCat entitlement gate
- no ads
- no tracking SDK
- no public commercial release plan for this milestone

The goal is to pass TestFlight external beta review and share the app with a small group of testers who understand the self-hosted setup.

## Why The Bridge Command Is Still `remodex`

The iPhone app is Dexora. The current computer-side bridge package is still the existing Remodex-compatible npm package, so the setup command remains:

```sh
remodex up
```

This is a compatibility detail. The app identity submitted to Apple is Dexora:

- app name: Dexora
- bundle ID: `com.davezfr.dexora`
- URL scheme: `dexora`
- Bonjour service type: `_dexora-permission._tcp`

## How The Pieces Fit

```text
iPhone running Dexora
        |
        | encrypted app session
        v
Relay reachable by phone and computer
        |
        | encrypted app session
        v
Computer-side bridge started by `remodex up`
        |
        v
Local coding agent, shell, git, files, and workspace
```

The relay routes traffic. It does not run the coding agent. After pairing and handshake, app payloads are encrypted between the phone and the bridge.

## Quick Start For Testers

Install the bridge package on the computer where your coding agent already works:

```sh
npm install -g remodex@latest
```

Start the bridge:

```sh
remodex up
```

Then on iPhone:

1. Install Dexora from TestFlight.
2. Open Dexora.
3. Scan the QR code printed by the bridge.
4. Send a short test message.

If reconnect fails later, run `remodex up` again and scan a fresh QR code.

## Local Source Checkout

This repository also contains the iOS project, bridge source, relay source, and self-hosting docs.

Useful paths:

- `CodexMobile/` contains the Xcode project and Swift app source.
- `phodex-bridge/` contains the Node bridge used by the `remodex` command.
- `relay/` contains the WebSocket relay server.
- `Docs/self-hosting.md` explains local and relay setup.
- `Legal/` contains Dexora privacy, support, and terms pages for TestFlight review.

## Running From Source

For a local source checkout, start the local launcher:

```sh
./run-local-remodex.sh
```

If your iPhone cannot reach the default local hostname, pass a LAN address:

```sh
./run-local-remodex.sh --hostname 192.168.1.10
```

For a tunnel or private relay URL:

```sh
./run-local-remodex.sh --relay-url https://example-tunnel-url
```

For regular iPhone testing, a stable private network path such as Tailscale is usually easier than relying on plain LAN discovery.

## Building The iOS App

Open the Xcode project:

```sh
open CodexMobile/CodexMobile.xcodeproj
```

The Dexora self-host beta uses:

- `SELF_HOSTED` Swift compilation condition
- bundle ID `com.davezfr.dexora`
- app icon source `CodexMobile/CodexMobile/Dexora.icon`
- public legal URLs under `https://davezfr.github.io/dexora/`

Do not commit private Apple credentials, APNs keys, relay hostnames, production URLs, or local signing overrides.

## Privacy And Security Notes

Dexora stores pairing and reconnect data on the iPhone. The paired computer handles the coding agent, repositories, tools, and model sessions.

Use Dexora only with computers and relays you trust. Review commands and code changes before relying on them.

For TestFlight metadata, publish:

- `Legal/DEXORA_PRIVACY_POLICY.md`
- `Legal/DEXORA_SUPPORT.md`
- `Legal/DEXORA_TERMS_OF_USE.md`

## Open Source Attribution

Dexora is derived from Remodex. The Remodex source is licensed under Apache 2.0.

Dexora does not use the original Remodex app name, icon, or bundle ID as its app identity. Remodex, OpenAI, Codex, Apple, and other names belong to their respective owners.

For a summary of Dexora-specific changes from upstream Remodex, see `MODIFICATIONS.md`.
