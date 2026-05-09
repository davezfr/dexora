# Dexora Self-Hosting Model

Dexora is a self-hosted iPhone companion. The iPhone app connects to a bridge running on your own computer, and that bridge controls the local coding agent.

This document explains the version boundary for the Dexora beta fork. It is written for testers, reviewers, and future maintainers who need to understand what the repo includes and what still belongs in private configuration.

## What This Repo Includes

The source tree includes:

- the Dexora iOS app source
- the Remodex-compatible bridge source used by the `remodex` command
- the relay server source
- local pairing and reconnect code
- self-hosting docs
- Dexora TestFlight review documents

The app identity for this fork is Dexora. The computer-side bridge command remains `remodex up` because the bridge package still uses the existing Remodex-compatible npm name.

## What This Repo Does Not Include

Keep these out of Git:

- Apple Developer credentials
- APNs keys or certificates
- private relay hostnames
- VPS IP addresses
- private production URLs
- local signing overrides
- TestFlight reviewer accounts or personal device identifiers
- model-provider tokens or ChatGPT session data

The public source should explain how to self-host. It should not contain one person's live deployment.

## Runtime Model

Dexora has four layers:

1. iPhone app
2. relay reachable by the phone and computer
3. bridge running on the paired computer
4. local coding agent and tools

The iPhone sends app requests through the relay to the bridge. The bridge talks to the local coding agent, shell, git, and workspace.

The relay is transport. It does not run the coding agent, clone repositories, execute git commands, or hold model credentials. After secure pairing and handshake, application payloads are encrypted between the iPhone and the bridge.

## Supported Beta Setups

For local source testing:

```sh
./run-local-remodex.sh
```

For the npm bridge path:

```sh
npm install -g remodex@latest
remodex up
```

For a custom relay:

```sh
REMODEX_RELAY="wss://your-relay.example.com/relay" remodex up
```

The app scans the QR code printed by the bridge. The first scan establishes trust. Later launches can reconnect to the trusted computer when the bridge and relay are reachable.

## TestFlight Model

The Dexora TestFlight build is prepared for small external testing.

Current beta assumptions:

- testers bring their own computer and coding-agent setup
- testers run the bridge themselves
- no Dexora account system exists
- no paid feature gate exists
- no RevenueCat or StoreKit flow is used in the self-host build
- reviewers can use the offline `Open Demo` path without a paired computer

Publish the Dexora privacy, support, and terms pages before submitting the build for external beta review.

## What To Preserve

When changing this fork, keep these boundaries intact:

- Do not reintroduce paid gating into the self-host build.
- Do not embed a private relay URL in source.
- Do not rename bridge protocol tags unless both phone and bridge are migrated together.
- Do not treat `remodex up` as a branding mistake; it is the current bridge command.
- Do not publish the upstream Remodex legal files as Dexora documents.

## Short Version

Dexora is the iPhone beta app. The bridge command is `remodex up`. The tester controls the computer, bridge, relay, coding agent, repositories, and credentials.

The repo should stay self-host friendly, reviewable, and free of private deployment secrets.
