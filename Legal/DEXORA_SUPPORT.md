# Dexora Support

Dexora is a small-group beta app for people who want to control a coding agent on their own computer from an iPhone.

This build is meant for learning, testing, and personal workflows. Expect bugs. Do not use it for work where a missed message, wrong command, or failed reconnect would cause serious harm.

## What You Need

- An iPhone with the Dexora TestFlight build installed.
- A Mac or other computer where your coding agent already works.
- The computer-side bridge package installed.
- A relay route that your iPhone can reach.

The current bridge command is still:

```sh
remodex up
```

Dexora keeps that command because the existing computer-side bridge package is published under the Remodex name. The iPhone app, icon, bundle ID, and beta identity are Dexora.

## Pairing

1. Start the bridge on your computer with `remodex up`.
2. Open Dexora on your iPhone.
3. Scan the QR code shown by the bridge.
4. Send a short test message before doing anything important.

After the first pairing, Dexora may reconnect to the trusted computer without scanning a new QR code. If reconnect fails, start the bridge again and scan a fresh QR code.

## What Dexora Can Do

Dexora can send messages, attachments, voice input, git actions, and worktree actions to the coding agent running on your paired computer.

The app does not run the coding agent itself. Your computer remains responsible for model access, shell commands, files, repositories, and credentials.

## Known Limits

- The beta may crash, disconnect, or show stale state.
- Some features require a newer bridge package.
- Local network and relay setup can fail even when the app itself is working.
- Voice transcription depends on the account and services available through your paired computer.
- The app is not an official OpenAI, Codex, Apple, or Remodex product.

## Privacy And Data

Dexora stores pairing and reconnect data on your iPhone. Messages and commands travel through the relay and bridge you configure, then run on your paired computer.

The self-host beta build does not include ads, tracking, RevenueCat, StoreKit, a Dexora account system, or in-app purchases.

Read the privacy policy before testing with private repositories or sensitive data.

## Related Pages

- Privacy Policy: `https://davezfr.github.io/dexora/privacy/`
- Terms: `https://davezfr.github.io/dexora/terms/`

## App Review Demo

Apple reviewers can open Dexora without a paired computer:

1. Launch Dexora.
2. Tap `Open Demo` on the onboarding screen.
3. Tap `Send Demo Message`.

Demo mode does not use a network connection, payment flow, private relay, or developer-owned computer.

## Getting Help

Use GitHub Issues for beta support and review questions:

`https://github.com/davezfr/dexora/issues`

For beta feedback, include:

- the Dexora app version and build number
- the bridge package version
- whether you were pairing, reconnecting, sending a message, using voice, or using git/worktree actions
- the exact error message shown in the app

Avoid sending secrets, private repository contents, API keys, access tokens, or private relay URLs in support messages.
