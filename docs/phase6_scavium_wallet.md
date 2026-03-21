# Phase 6 — Packaging, Branding, Release, and Store Deployment

## Overview

Phase 6 focuses on transitioning SCAVIUM Wallet from a functionally complete and production-ready application (Phases 1 → 5.5.6) into a distribution-ready product across all supported platforms.

This phase strictly covers:

- Application packaging
- Platform configuration
- Signing and certificates
- Branding and visual identity
- Build generation
- Store preparation (Play Store / App Store)

No functional wallet changes are introduced in this phase.

---

## Phase 6.5 — Cross-Platform Branding Baseline

### Objective

Establish a single, consistent branding foundation across all platforms before platform-specific packaging begins.

This ensures:

- Visual consistency
- Asset reuse across platforms
- Simplified maintenance
- Predictable build outputs

---

## Branding Principles

- Consistency over customization
- Single source of truth for assets
- Platform adaptation without altering identity
- No runtime branding logic (compile-time assets only)

---

## App Identity

### App Name (Display)

- SCAVIUM Wallet

### Internal Name

- scavium_wallet

### Existing Brand Asset Set

The project already includes a branding kit containing the official SCAVIUM visual assets.

Current source assets:

- `logo/scavium-logo.svg`
- `logo/scavium-logo.png`
- `icon/scavium-icon.svg`
- `icon/scavium-icon.png`
- `favicon/favicon-32.png`
- `favicon/favicon-16.png`
- `favicon/favicon.ico`
- `token/scavium-token-256.png`

These assets are treated as the authoritative visual baseline for Phase 6.

---

## Asset Roles

### Primary Logo

Used for:

- documentation
- splash branding
- website/header contexts when needed

Source:

- `logo/scavium-logo.svg`

Fallback raster:

- `logo/scavium-logo.png`

### Primary App Icon

Used for:

- Android launcher icon
- iOS app icon
- Web app icon
- Windows application icon

Source:

- `icon/scavium-icon.svg`

Fallback raster:

- `icon/scavium-icon.png`

### Web Favicon Assets

Used for:

- browser tab icon
- basic favicon compatibility

Sources:

- `favicon/favicon.ico`
- `favicon/favicon-32.png`
- `favicon/favicon-16.png`

### Token Visual Asset

Used only as a branding/supporting asset where appropriate, but not as the main application icon unless explicitly required.

Source:

- `token/scavium-token-256.png`

---

## Recommended Internal Asset Structure

To simplify packaging workflows, branding assets should be consolidated under a stable Flutter project directory:

assets/
  branding/
    logo/
      scavium-logo.svg
      scavium-logo.png
    icon/
      scavium-icon.svg
      scavium-icon.png
    favicon/
      favicon.ico
      favicon-32.png
      favicon-16.png
    token/
      scavium-token-256.png

This structure does not change the visual identity. It only standardizes asset access during packaging and release preparation.

---

## Derived Packaging Assets

The following derived assets should be generated from the official branding kit during Phase 6:

### Android

- launcher icon set
- adaptive icon foreground
- adaptive icon background

Derived from:

- `icon/scavium-icon.svg`

### iOS

- AppIcon asset catalog

Derived from:

- `icon/scavium-icon.svg`

### Web

- `icon-192.png`
- `icon-512.png`

Derived from:

- `icon/scavium-icon.svg`

### Windows

- application `.ico`

Derived from:

- `icon/scavium-icon.svg`

---

## Master Icon Guidance

The current raster icon is available at 512x512, which is sufficient for several platform tasks.

However, the preferred master source for release packaging must be the SVG asset:

- `icon/scavium-icon.svg`

This avoids quality loss and allows clean export to larger target sizes such as 1024x1024 when required by stores or packaging tooling.

---

## Splash Strategy

Use native splash screens at platform level.

Recommended baseline:

- background aligned with current SCAVIUM Wallet dark theme
- centered SCAVIUM branding
- minimal visual noise
- no replacement of native splash with a Flutter-rendered splash during platform launch

Preferred splash source:

- `logo/scavium-logo.svg`

or a raster export derived from it if required by the packaging toolchain.

---

## Platform Mapping

| Platform | Primary Asset | Supporting Assets | Notes |
|----------|---------------|------------------|------|
| Android  | `icon/scavium-icon.svg` | derived adaptive assets | launcher + adaptive icon |
| iOS      | `icon/scavium-icon.svg` | derived AppIcon set | asset catalog export |
| Web      | `favicon/favicon.ico` and derived web icons | favicon set | browser + PWA |
| Windows  | derived `.ico` from `icon/scavium-icon.svg` | optional favicon fallback | desktop runner icon |

---

## Branding Validation Checklist

- [ ] Official SCAVIUM icon is used consistently across all platforms
- [ ] Official SCAVIUM logo is used consistently for splash and brand presentation
- [ ] No placeholder icons remain in any target platform
- [ ] Web favicon assets are aligned with the branding kit
- [ ] Store/export assets are generated from SVG where possible
- [ ] No stretched, cropped, or low-quality icon outputs are introduced

---

## Output of Phase 6.5

At the end of this subphase:

- The branding baseline is formally defined
- Official SCAVIUM assets are mapped to each platform
- Derived packaging assets are clearly identified
- The project is ready to proceed to platform-specific packaging

---

## Next Phase

Phase 6.1 — Android Packaging & Play Store Readiness

---

## Phase 6.1 — Android Packaging & Play Store Readiness

### Objective

Prepare the Android target for production release by finalizing platform branding, native launch configuration, package identity, release signing, and distributable build generation.

This subphase does not introduce any wallet logic changes. All work is limited to packaging, branding, release configuration, and build pipeline stabilization.

---

### Scope

Phase 6.1 includes:

- Android package identity finalization
- launcher/app icon replacement
- native splash integration
- release signing configuration
- Android build tooling alignment
- generation of production-ready release artifacts

It explicitly excludes:

- wallet feature changes
- navigation changes
- RPC logic changes
- state management changes
- business logic refactors

---

### Package Identity

Android package identity was finalized using the production namespace:

- `com.geryon.scavium_wallet`

The Android entry point was aligned accordingly, including the `MainActivity.kt` package path and declaration.

---

### App Label

The visible Android application label was updated to:

- `SCAVIUM Wallet`

This replaces the default Flutter template label and aligns the installed app identity with the SCAVIUM product branding.

---

### Branding Integration

Android branding was updated using the official SCAVIUM branding kit.

Applied branding areas include:

- launcher icons
- adaptive icon assets
- native launch screen resources

The Android target no longer uses the default Flutter placeholder branding.

---

### Native Splash

The Android launch experience was aligned with the SCAVIUM Wallet branding using native Android launch resources.

During implementation, an intermediate attempt was made to use Android 12+ splash theme attributes such as `postSplashScreenTheme`. This approach was removed in favor of the standard Flutter-native Android launch theme structure to maintain compatibility and reduce release risk.

Final Android splash behavior uses:

- `LaunchTheme`
- `NormalTheme`
- `launch_background.xml`

This preserves a branded native launch screen without introducing unnecessary platform-specific complexity.

---

### Screenshot Protection Implementation

The previous Android screenshot protection dependency based on `flutter_windowmanager` was removed due to Android Gradle Plugin compatibility issues.

The project preserved the existing Dart-level API:

- `ScreenshotGuard.enableProtection()`
- `ScreenshotGuard.disableProtection()`

Internally, the implementation was replaced with a native Android `MethodChannel` bridge that applies and clears:

- `WindowManager.LayoutParams.FLAG_SECURE`

This change removed a legacy dependency without changing the application architecture or security flow.

---

### Android Tooling Alignment

To satisfy current Android dependency requirements and allow release builds to complete successfully, the Android build tooling was updated.

Final Android tooling baseline:

- Android Gradle Plugin: `8.9.1`
- Gradle Wrapper: `8.11.1`
- Kotlin Android Plugin: `2.1.0`
- JDK: `17`

This update was required to resolve release build failures caused by dependency metadata compatibility constraints.

---

### Release Signing

A dedicated Android release keystore was generated and configured.

Release signing details:

- keystore type: PKCS12
- alias: `scavium`

The project now signs release artifacts using a dedicated release signing configuration instead of the default debug signing setup.

Sensitive signing files were intentionally kept outside version control.

---

### Signing Verification

Release signing configuration was validated using Gradle signing reports.

The release variant resolved correctly to the configured SCAVIUM release keystore and exposed stable certificate fingerprints for store registration and release tracking.

---

### Build Artifacts

The Android release pipeline successfully generated both primary production artifacts.

Generated artifacts:

- `build/app/outputs/bundle/release/app-release.aab`
- `build/app/outputs/flutter-apk/app-release.apk`

The Android App Bundle is the primary artifact intended for Google Play Console upload.

The APK artifact is intended for direct installation, local validation, and manual QA.

---

### Repository Safety

Signing-related files were excluded from version control.

Protected files include:

- `android/key.properties`
- `android/keystores/`
- `*.jks`
- `*.keystore`

This ensures release signing material is not committed into the repository.

---

### Result

At the end of Phase 6.1:

- Android package identity is finalized
- Android branding is applied
- native splash is stabilized
- screenshot protection remains functional
- release signing is configured and validated
- release build generation is successful
- Android artifacts are ready for internal validation and Play Store preparation

---

### Next Phase

Phase 6.3 — Web Packaging & Production Branding

---

## Phase 6.3 — Web Packaging & Production Branding

### Objective

Prepare the Web target for production by replacing default Flutter template metadata and assets with SCAVIUM branding and ensuring a consistent Progressive Web App (PWA) configuration.

---

### Scope

This subphase includes:

- HTML metadata update
- PWA manifest configuration
- favicon and icon replacement
- branding alignment with SCAVIUM identity
- production web build validation

No wallet logic or application behavior changes are introduced.

---

### HTML Metadata

The default Flutter template metadata was replaced.

Updated elements include:

- application title
- meta description
- Apple web app configuration
- favicon references

Final application title:

- SCAVIUM Wallet

---

### Manifest Configuration

The web manifest was updated to reflect the SCAVIUM Wallet identity.

Key updates:

- `name`: SCAVIUM Wallet
- `short_name`: SCAVIUM
- `description`: self-custody wallet description
- background and theme colors aligned to dark UI

Default Flutter template values were removed.

---

### Icon Replacement

Default Flutter icons were replaced with SCAVIUM branding assets.

Generated icons:

- `icon-192.png`
- `icon-512.png`

All icons were derived from the official SCAVIUM SVG asset (`icon/scavium-icon.svg`).

---

### Favicon

Default Flutter favicon was replaced with SCAVIUM favicon assets.

This ensures consistent browser tab identity across environments.

---

### Build Validation

The web build pipeline was executed successfully:

- `fvm flutter build web --release`

Output directory:

- `build/web/`

The application loads correctly with updated branding and metadata.

---

### Result

At the end of Phase 6.3:

- Web branding is aligned with SCAVIUM identity
- PWA metadata is correctly configured
- default Flutter placeholders are removed
- web build is production-ready and aligned with SCAVIUM branding

---

### Next Phase

Phase 6.4 — Windows Packaging & Desktop Branding