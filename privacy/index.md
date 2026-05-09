# Dexora Privacy Policy

Effective date: 2026-05-09

This policy applies to the Dexora iOS beta build distributed for small-group testing.

Dexora is a self-hosted companion app. It connects your iPhone to a bridge running on your own computer so you can control a local coding agent from your phone. Dexora does not provide a hosted user account, advertising system, subscription service, or in-app purchase flow in this beta build.

## How Dexora Works

Dexora has three moving parts:

- the iPhone app
- the computer-side bridge that you run yourself
- a relay endpoint that carries the connection between the phone and the bridge

Your coding agent, repositories, terminal commands, file edits, and workspace state remain on the paired computer. Dexora sends instructions to that computer and displays responses from it.

After pairing, Dexora uses an encrypted session for app traffic between the iPhone and the paired bridge. A relay can route connection traffic, but it is not intended to receive readable prompts, code, messages, or file contents after the secure session is established.

## Data Stored On Your iPhone

Dexora stores data on your device so the app can reconnect and show your recent state. This may include:

- pairing information, relay URL, session identifiers, public keys, and trusted computer records
- app settings and connection state
- conversation lists, local message cache, workspace labels, branch names, and other UI state
- attachments or thumbnails selected by you for display or sending
- temporary files created while using voice, image, or export features

Pairing and reconnect records may use iOS Keychain or local app storage. Local message and UI cache remain on your device unless you clear app data or delete the app.

## Data Sent Through The Bridge

When you use Dexora with a paired computer, the app may send:

- messages you type
- selected images or camera captures
- voice transcription results
- requests to list chats, projects, branches, worktrees, files, or agent status
- commands for features you choose, such as creating a branch, opening a worktree, resuming a thread, or waking the paired computer

The bridge forwards these requests to the local coding agent and related tools on your computer. The result may include generated text, tool output, file names, diffs, logs, or other workspace information shown in the app.

## Camera, Photos, Microphone, And Local Network

Dexora asks for device permissions only when a feature needs them:

- Camera access is used to scan pairing QR codes and capture images you choose to attach.
- Photo library access is used to select images for messages and to save generated images or attachments when you request it.
- Microphone access is used to record voice input for transcription.
- Local network access is used to connect to a bridge or relay reachable from your device.

You can deny these permissions in iOS. Some related features will stop working if permission is not granted.

## Voice Transcription

If you use voice input, Dexora records a temporary audio clip on the iPhone. The app may ask the paired bridge for a ChatGPT or OpenAI session token and send the audio clip from the iPhone to the transcription service.

Dexora does not ask for your ChatGPT password. The paired bridge manages the login flow on your computer. The transcription provider processes the audio under its own terms and privacy policy.

## Payments, Analytics, And Tracking

This Dexora beta build does not use:

- third-party advertising
- third-party tracking SDKs
- RevenueCat entitlement checks
- StoreKit in-app purchases
- Dexora subscription analytics

Apple may still process TestFlight, crash, diagnostic, device, and account information under Apple's own policies when you install or test the app through Apple services.

## Third Parties

Dexora can interact with services you configure or use through your paired computer. These may include:

- Apple TestFlight, iOS, iCloud, and device services
- OpenAI, ChatGPT, or another model provider used by your coding agent or transcription flow
- Git hosting, package managers, shells, terminals, and developer tools used by your computer
- a relay service you self-host or choose to use

Dexora does not control the privacy practices of those services. Review their policies before using them with private repositories, credentials, personal data, or confidential work.

## Retention And Deletion

Dexora does not maintain a central Dexora user account database for this beta.

You can remove Dexora data by deleting the app from your iPhone. You can also re-pair the app, remove trusted computer records where the app provides that control, or delete local bridge and coding-agent data from your computer.

Data handled by Apple, OpenAI, ChatGPT, relay operators, Git providers, package managers, or other third-party services follows those services' retention and deletion rules.

## Security Notes

Dexora is designed for self-hosted use, but your security still depends on your setup. Keep your phone, computer, bridge process, relay endpoint, and developer accounts secure.

Do not pair Dexora with a computer you do not control. Do not expose a relay or bridge to people you do not trust.

## Children

Dexora is not designed for children. The beta is intended for invited testers who understand that the app controls developer tools on their own computer.

## Changes

This policy may change as the beta changes. Future builds may add or remove features, permissions, relay options, or account flows.

## Contact

For privacy or support questions, use the Dexora support page linked from the TestFlight listing or App Store Connect metadata.
