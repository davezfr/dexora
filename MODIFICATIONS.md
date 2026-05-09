# Modifications From Upstream Remodex

Dexora is an unofficial self-hosted beta fork based on the open-source Remodex project, licensed under Apache 2.0.

This file records the main changes made for the Dexora small-group TestFlight beta.

- Dexora public beta preparation date: 2026-05-09
- Upstream repository: `https://github.com/Emanuele-web04/remodex`
- Upstream baseline commit: `4bf799fdb6bbbddb5c54db118d0b7157b1eacc53`
- Dexora public repository: `https://github.com/davezfr/dexora`

The upstream project did not include a `NOTICE` file at the baseline commit above. The Apache 2.0 license text is preserved in `LICENSE`.

## Identity And Branding

Dexora uses its own beta app identity instead of the upstream Remodex App Store identity.

Main changes:

- app display name changed to `Dexora`
- app icon changed to the Dexora icon set
- bundle identifiers changed to the `com.davezfr.dexora` namespace
- URL scheme changed to `dexora`
- Bonjour service type changed to `_dexora-permission._tcp`
- in-app open-source link changed to the Dexora public repository
- user-visible branch/worktree prefix changed to `dexora/`

Representative files:

- `README.md`
- `CodexMobile/BuildSupport/Base.xcconfig`
- `CodexMobile/BuildSupport/CodexMobile-Info.plist`
- `CodexMobile/CodexMobile.xcodeproj/project.pbxproj`
- `CodexMobile/CodexMobile/Dexora.icon/`
- `CodexMobile/CodexMobile/Assets.xcassets/AppLogo.imageset/`
- `CodexMobile/CodexMobile/Services/AppEnvironment.swift`
- `CodexMobile/CodexMobile/Views/OpenSourceBadge.swift`
- `CodexMobile/CodexMobile/Views/AboutDexoraView.swift`
- `CodexMobile/CodexMobile/Views/Onboarding/`
- `CodexMobile/CodexMobile/Views/QRScannerView.swift`
- `CodexMobile/CodexMobile/Views/Sidebar/SidebarHeaderView.swift`
- `CodexMobile/CodexMobile/Views/Turn/TurnGitBranchSelector.swift`

## Legal, Support, And Review Documents

Dexora uses its own public beta documents rather than the upstream Remodex legal pages.

Main changes:

- Dexora privacy policy written for the self-hosted beta
- Dexora terms written for small-group beta testing
- Dexora support page written with GitHub Issues as the support channel
- public GitHub Pages routes prepared for privacy, support, and terms

Representative files:

- `Legal/DEXORA_PRIVACY_POLICY.md`
- `Legal/DEXORA_TERMS_OF_USE.md`
- `Legal/DEXORA_SUPPORT.md`
- `Legal/README.md`
- `privacy/index.md`
- `support/index.md`
- `terms/index.md`

## Self-Hosted Configuration

Dexora is configured for testers who run their own bridge and relay path.

Main changes:

- hosted relay defaults removed from the open-source build
- private endpoint/signing overrides moved to ignored local config
- self-host runtime boundary documented
- review/demo mode kept available without a private computer or relay

Representative files:

- `SELF_HOSTING_MODEL.md`
- `Docs/self-hosting.md`
- `CodexMobile/BuildSupport/Base.xcconfig`
- `CodexMobile/BuildSupport/PrivateOverrides.xcconfig.example`
- `CodexMobile/CodexMobile/Services/AppEnvironment.swift`
- `CodexMobile/CodexMobile/Views/ReviewDemoView.swift`
- `run-local-remodex.sh`

## Monetization Removal For The Beta

Dexora's self-host TestFlight beta does not include a paid access gate.

Main changes:

- RevenueCat initialization disabled in `SELF_HOSTED` builds
- self-host subscription service grants local app access
- StoreKit and RevenueCat signing/provisioning requirements removed from the self-host target
- privacy manifest updated to remove purchase-history collection from the self-host beta

Representative files:

- `CodexMobile/CodexMobile/CodexMobileApp.swift`
- `CodexMobile/CodexMobile/Services/Payments/SubscriptionService.swift`
- `CodexMobile/CodexMobile/PrivacyInfo.xcprivacy`
- `CodexMobile/CodexMobile.xcodeproj/project.pbxproj`
- `Legal/DEXORA_PRIVACY_POLICY.md`
- `Legal/DEXORA_TERMS_OF_USE.md`

## Bridge Compatibility

The iPhone app identity is Dexora, but the current computer-side bridge command remains `remodex up` for compatibility with the existing npm package and protocol names.

Main changes:

- documentation explains why the bridge command still uses `remodex`
- user-facing product identity changed to Dexora where it is not a command, package name, protocol tag, or source attribution
- bridge compatibility messages updated from product identity wording to Dexora beta wording where appropriate

Representative files:

- `README.md`
- `SELF_HOSTING_MODEL.md`
- `Docs/self-hosting.md`
- `phodex-bridge/package.json`
- `phodex-bridge/src/ios-app-compatibility.js`
- `relay/apns-client.js`
- `CodexMobile/RemodexMenuBar/BridgeMenuBarViews.swift`

## What Was Preserved

- Apache 2.0 license text remains in `LICENSE`.
- Upstream Remodex attribution is kept in public docs and the in-app about surface.
- Protocol labels and bridge command names that are required for compatibility are not renamed blindly.
- The fork does not claim to be official OpenAI, Codex, Apple, or Remodex software.
