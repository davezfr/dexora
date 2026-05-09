# Dexora Relay

This folder contains the WebSocket relay used by the Dexora beta and the Remodex-compatible bridge.

The relay exists so an iPhone and a computer-side bridge can find each other and exchange encrypted app traffic. It is transport infrastructure. It does not run the coding agent and should not contain private deployment defaults.

## What The Relay Does

- Accepts bridge and iPhone WebSocket connections.
- Pairs one live bridge session with one mobile client session.
- Helps a trusted iPhone resolve the current live session for a paired computer.
- Forwards secure control messages and encrypted app payloads.
- Exposes a health check endpoint.
- Exposes optional push endpoints only when push is enabled.
- Logs connection metadata and payload sizes rather than plaintext prompts or code.

## What The Relay Does Not Do

- It does not run Codex or any coding agent.
- It does not execute shell or git commands.
- It does not clone or read repositories.
- It does not hold model-provider tokens.
- It does not decrypt Dexora application payloads after the secure session is active.

The paired computer handles the coding agent, workspace, files, git operations, and credentials.

## Basic Flow

1. The bridge starts on the computer.
2. The bridge opens a WebSocket to `/relay/{sessionId}`.
3. The bridge prints a QR code with relay and session details.
4. Dexora scans the QR code.
5. Dexora opens a WebSocket to the same relay session.
6. The app and bridge perform the secure handshake.
7. The relay forwards encrypted traffic between them.

Later, a trusted iPhone can ask the relay to resolve the computer's current live session. The relay only returns a session after signature, nonce, and freshness checks pass.

## Endpoints

WebSocket:

- `/relay/{sessionId}`

Required role header:

- `x-role: mac`
- `x-role: iphone`
- `x-role: android`

HTTP:

- `GET /health`
- `POST /v1/trusted/session/resolve`
- `POST /v1/push/session/register-device`
- `POST /v1/push/session/notify-completion`

Push endpoints are optional. Leave push disabled for the first Dexora beta unless APNs and bridge-side push configuration are ready.

## Close Codes

- `4000`: invalid session or role
- `4001`: previous bridge connection replaced
- `4002`: session unavailable or bridge disconnected
- `4003`: previous mobile connection replaced

## Running Locally

```sh
cd relay
npm install
npm start
```

Health check:

```sh
curl http://127.0.0.1:9000/health
```

Expected response:

```json
{"ok":true}
```

## Using The Relay From The Bridge

Point the bridge at the relay:

```sh
REMODEX_RELAY="wss://relay.example.com/relay" remodex up
```

The environment variable and bridge command still use the existing Remodex-compatible naming. Dexora is the iOS beta app identity.

## Reverse Proxy

If the relay runs behind a proxy:

- forward WebSocket upgrades
- forward `/relay/...` to the Node process
- use `wss://` for internet-facing routes
- strip shared path prefixes before forwarding
- set `REMODEX_TRUST_PROXY=true` only behind a proxy that sanitizes forwarded IP headers

Keep real relay URLs, APNs credentials, private hostnames, and deployment secrets out of committed source.

## Code Entry Points

- `server.js` exports `createRelayServer()`.
- `relay.js` exports `setupRelay(wss)`.

Use these entry points if you need to embed the relay in another Node server.
