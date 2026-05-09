# Dexora Self-Hosting Guide

Dexora connects an iPhone to a coding agent running on your own computer.

This guide covers the self-hosted beta setup. It avoids private deployment details and uses placeholder relay URLs. Keep your real hostnames, credentials, Apple keys, and local overrides outside Git.

## What Runs Where

On your iPhone:

- Dexora iOS app

On your computer:

- the bridge started by `remodex up`
- Codex or another supported local coding-agent runtime
- git, shell, files, credentials, and workspace tools

On a relay host:

- the WebSocket relay used by the phone and bridge

The relay routes the connection. The coding agent and workspace actions run on your computer.

## Before You Start

You need:

- Node.js installed on the computer
- a working coding-agent setup on that computer
- Dexora installed on your iPhone
- a relay URL reachable by both iPhone and computer

For quick local testing, the source checkout can start a local relay. For regular iPhone use, prefer a stable private network path such as Tailscale, a private VPS, or another relay endpoint you control.

## Option 1: Source Checkout Local Test

From this repo:

```sh
./run-local-remodex.sh
```

The launcher starts a local relay, starts the bridge, and prints a QR code.

Then:

1. Open Dexora on your iPhone.
2. Scan the QR code from inside the app.
3. Send a short test message.
4. Close and reopen the app to test trusted reconnect.

If the iPhone cannot reach the advertised hostname, pass a LAN address:

```sh
./run-local-remodex.sh --hostname 192.168.1.10
```

Local Wi-Fi routing can be fragile on iOS. If pairing fails even though the relay health check works, use a tunnel or private network relay instead of spending too long on LAN discovery.

## Option 2: Bridge From npm

Install or update the bridge package:

```sh
npm install -g remodex@latest
```

Start the bridge:

```sh
remodex up
```

Dexora still uses this command because the current bridge package is Remodex-compatible and published under that name. The iPhone beta app is Dexora.

## Option 3: Custom Relay

Run the relay on a machine your iPhone and computer can both reach.

From this repo:

```sh
cd relay
npm install
npm start
```

The relay listens on port `9000` by default.

Health check:

```sh
curl http://127.0.0.1:9000/health
```

Expected response:

```json
{"ok":true}
```

Point the bridge at your relay:

```sh
REMODEX_RELAY="wss://relay.example.com/relay" remodex up
```

For a source checkout launcher:

```sh
./run-local-remodex.sh --relay-url https://relay.example.com
```

The QR code carries the relay URL and session details. The iPhone does not need a hardcoded relay URL in the app bundle.

## Reverse Proxy Notes

If the relay sits behind Nginx, Caddy, Traefik, Cloudflare Tunnel, or another proxy:

- forward WebSocket upgrade headers
- forward `/relay/...` to the Node relay
- expose `wss://` when crossing the public internet
- strip shared path prefixes before forwarding to the relay process
- set `REMODEX_TRUST_PROXY=true` only when the proxy sanitizes forwarded IP headers

Example shared path:

```sh
REMODEX_RELAY="wss://api.example.com/dexora/relay" remodex up
```

In that setup, configure the proxy so the relay process receives `/relay/...`, not `/dexora/relay/...`.

## Pairing And Reconnect

First pairing:

1. The bridge starts and prints a QR code.
2. Dexora scans the QR code.
3. The app and bridge verify each other and establish an encrypted app session.
4. Dexora saves trusted computer information on the iPhone.

Later reconnect:

1. Start or keep the bridge running on the paired computer.
2. Open Dexora.
3. The app tries to resolve the current live bridge session for the trusted computer.
4. If reconnect fails, scan a fresh QR code.

The built-in background service path is macOS-focused. If you use another operating system, pairing and relay routing can still work, but you may need your own service wrapper to keep the bridge alive.

## Push Notifications

Push is optional and not required for the first Dexora beta.

Leave push disabled unless you are ready to manage:

- APNs credentials
- a bridge-side push service URL
- relay-side push configuration
- operational monitoring for notification delivery

The app can be tested without push.

## What Not To Commit

Keep these out of the repo:

- real relay hostnames
- VPS IP addresses
- Apple Developer credentials
- APNs keys or certificates
- model-provider tokens
- ChatGPT session data
- private build overrides
- TestFlight reviewer personal data

Use environment variables, private config, or local override files for deployment-specific values.

## Troubleshooting

### Dexora cannot scan or use the QR code

Check that you opened the QR from inside Dexora, not the system Camera app. A normal QR scanner may treat the pairing payload as plain text.

### The bridge starts but the iPhone cannot connect

Check:

- the relay URL is reachable from the iPhone
- the bridge is using the same relay URL printed in the QR
- the reverse proxy supports WebSocket upgrades
- the URL uses `wss://` for internet-facing routes

### The relay health check works but pairing fails

The HTTP health check only proves the relay process is alive. Pairing also needs a working WebSocket path and the correct `/relay/...` route.

### Trusted reconnect fails

Start the bridge again and scan a new QR code. If reconnect works after a fresh scan, the old trusted session or relay route was stale.

### The app opens but cannot do useful work

Dexora is not a standalone chat app. Confirm that the coding agent works on the paired computer before debugging the iPhone app.

## App Review Demo

For Apple review or first-look testing without a paired computer:

1. Launch Dexora.
2. Tap `Open Demo` on the onboarding screen.
3. Tap `Send Demo Message`.

Demo mode does not use the network, a relay, a payment system, or a developer-owned computer.

## Minimal Path

For most beta testers:

```sh
npm install -g remodex@latest
remodex up
```

Then install Dexora from TestFlight, scan the QR code, and send a short test message.
