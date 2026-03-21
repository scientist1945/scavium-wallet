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