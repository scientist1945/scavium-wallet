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

---


## Phase 6.4 — Windows Packaging & Desktop Branding

### Objective

Prepare the Windows desktop target for production distribution by aligning executable identity, application metadata, and visual branding with SCAVIUM standards.

---

### Scope

This subphase includes:

- executable naming strategy
- Windows metadata configuration
- application icon replacement
- desktop branding alignment
- release build validation

No wallet functionality or architecture changes are introduced.

---

### Executable Naming

The Windows build kept a technical executable filename for CMake compatibility:

- `scavium_wallet.exe`

User-facing branding was applied through Windows file metadata and icon resources rather than through a spaced executable filename.

This preserves build stability while keeping the application identity aligned with SCAVIUM branding in Windows Explorer and system dialogs.

---

### Application Metadata

Windows application metadata was updated via the `Runner.rc` resource file.

Updated fields include:

- CompanyName
- FileDescription
- FileVersion
- ProductName
- ProductVersion
- OriginalFilename
- LegalCopyright

Brand-visible values were aligned with:

- `SCAVIUM Wallet`

The technical original filename remains:

- `scavium_wallet.exe`

This ensures proper identification in Windows Explorer and system dialogs while preserving build compatibility.

---

### Icon Replacement

The default Flutter application icon was replaced with the SCAVIUM branding icon.

The icon file:

- `windows/runner/resources/app_icon.ico`

was generated from the official SCAVIUM SVG asset to preserve visual quality.

The icon includes multiple resolutions:

- 16x16
- 32x32
- 48x48
- 256x256

---

### Build Validation

The Windows release build pipeline was executed successfully:

- `fvm flutter build windows --release`

Output directory:

- `build/windows/x64/runner/Release/`

Generated executable:

- `build/windows/x64/runner/Release/scavium_wallet.exe`

Runtime validation confirmed:

- executable generation
- metadata propagation
- icon replacement
- successful application launch

---

### Result

At the end of Phase 6.4:

- Windows executable generation is stable
- application metadata is aligned with SCAVIUM branding
- application icon is replaced
- default Flutter placeholders are removed
- Windows build is production-ready

---

### Next Phase

Phase 6.2 — iOS Packaging & App Store Readiness

---

## Phase 6.2 — iOS Packaging & App Store Readiness

### Status

Pending.

---

### Reason

This phase requires a macOS environment with Xcode and Apple Developer signing configuration.

Execution was intentionally deferred to avoid incomplete or unverified setup.

---

### Scope (Planned)

- Bundle identifier configuration
- App name and branding
- AppIcon and launch assets
- Info.plist configuration
- signing (certificates + provisioning profiles)
- archive and validation for App Store Connect

---

### Next Step

Execute Phase 6.2 on a macOS environment with Xcode.

---

## Phase 6.6 — Release Preparation

### Objective

Prepare SCAVIUM Wallet for controlled release by defining versioning rules, artifact conventions, validation criteria, release checkpoints, and operational readiness requirements.

This phase does not introduce feature changes. It formalizes the release process around the already completed packaging and branding work.

---

### Scope

This subphase includes:

- versioning strategy
- build artifact naming conventions
- release candidate criteria
- pre-release validation checklist
- release checklist
- platform readiness summary
- deferred platform tracking

It excludes:

- new wallet functionality
- architecture changes
- platform redesign
- store listing content finalization

---

### Release Baseline

At the beginning of Phase 6.6, the project status is:

- Phase 6.5 completed
- Phase 6.1 completed
- Phase 6.3 completed
- Phase 6.4 completed
- Phase 6.2 deferred pending macOS/Xcode environment

This means Android, Web, and Windows packaging are operational, while iOS remains intentionally pending.

---

### Target Environment

The current release preparation is targeting:

- `Testnet`

This release is intended for controlled distribution and validation before any production deployment.

---

### Versioning Strategy

Current release candidate version:

- `0.2.1+3`

Versioning follows:

- `MAJOR.MINOR.PATCH+BUILD`

Version intent:

- `MAJOR`: major product milestones
- `MINOR`: feature phase increments
- `PATCH`: fixes and stabilization
- `BUILD`: build iteration number

---

### Release Candidate Status

Current build status:

- **Release Candidate (RC1)**

Validation status:

- user-level testing executed
- core flows exercised by real users
- minor regressions identified (Android)

The current release is **not considered final** and requires stabilization.

---

### Known Issues

At the time of Phase 6.6:

- some Android behaviors previously working have regressed
- issues are non-blocking but require correction before production release

These issues must be resolved before advancing to production deployment.

---

### Artifact Conventions

Generated artifacts:

- Android App Bundle:
  - `build/app/outputs/bundle/release/app-release.aab`
- Android APK:
  - `build/app/outputs/flutter-apk/app-release.apk`
- Web build:
  - `build/web/`
- Windows release executable:
  - `build/windows/x64/runner/Release/scavium_wallet.exe`

Suggested archive naming:

- `scavium-wallet-testnet-v0.2.1+3-android.aab`
- `scavium-wallet-testnet-v0.2.1+3-android.apk`
- `scavium-wallet-testnet-v0.2.1+3-web.zip`
- `scavium-wallet-testnet-v0.2.1+3-windows.zip`

---

### Release Freeze Rule

Once a release candidate is declared:

Allowed changes:

- bug fixes
- crash fixes
- regression fixes
- packaging corrections
- signing corrections

Not allowed:

- new features
- architectural changes
- UI redesign

---

### Pre-Release Validation Checklist

- [x] Flutter version validated
- [x] version updated to `0.2.1+3`
- [x] branding assets finalized
- [x] Android AAB build successful
- [x] Android APK build successful
- [x] Web build successful
- [x] Windows build successful
- [x] Android signing validated
- [x] placeholders removed
- [x] app naming consistent
- [x] initial user testing performed
- [ ] Android regressions resolved
- [ ] final smoke test executed post-fix

---

### Smoke Test Minimum Set

Validated partially:

- [x] wallet creation
- [x] wallet import
- [x] unlock flow
- [x] balance loading
- [x] transaction flows access

Pending re-validation after fixes:

- [ ] Android-specific regression flows
- [ ] full transaction cycle verification
- [ ] session persistence validation

---

### Platform Readiness Summary

#### Android

Status:

- Release Candidate

Notes:

- build stable
- signing correct
- regressions pending fix

---

#### Web

Status:

- Release-ready

---

#### Windows

Status:

- Release-ready

---

#### iOS

Status:

- Deferred

Reason:

- requires macOS and Xcode environment

---

### Result

At the end of Phase 6.6:

- release process is defined
- release candidate (RC1) is established
- artifacts are generated and traceable
- testnet distribution is enabled
- known issues are identified
- production release is pending stabilization

---

### Next Phase

Phase 6.7 — Store Deployment

---

## Phase 6.7 — Store Deployment

### Objective

Deploy SCAVIUM Wallet through Google Play using a staged rollout strategy to ensure stability and controlled exposure.

---

### Strategy

Deployment follows a progressive rollout model:

- Internal testing
- Closed testing
- Production release

This minimizes risk and allows iterative stabilization.

---

### Internal Testing

The application was deployed via Google Play Internal Testing.

Purpose:

- validate installation flow
- detect runtime issues
- identify regressions
- verify signing and distribution

Artifacts used:

- Android App Bundle (`.aab`)

Testers include:

- development team
- technical users

The application is currently installed and actively tested by real users.

---

### Iteration Cycle

During internal testing:

- issues are identified and reproduced
- fixes are applied incrementally
- build number is increased (`+BUILD`)
- new release candidates are uploaded

Example progression:

- `0.2.1+3` → `0.2.1+4` → `0.2.1+5`

---

### Closed Testing (Planned)

Once internal testing stabilizes:

- the application will be promoted to Closed Testing
- a broader user group will be introduced
- real-world usage scenarios will be validated

---

### Production Release (Planned)

Production deployment will be executed only when:

- no blocking issues remain
- Android regressions are resolved
- core wallet flows are fully validated
- release candidate is stable

---

### Result

At the current state:

- SCAVIUM Wallet is distributed via Internal Testing
- real user feedback is being collected
- stabilization phase is active

---

### Next Phase

Phase 7 — Stabilization & Bug Fixing