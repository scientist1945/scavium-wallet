import 'package:flutter/material.dart';

/// Semantic color tokens for the SCAVIUM visual system.
///
/// Tokens describe UI intent instead of raw color names. The current values
/// preserve the established dark SCAVIUM identity and provide the stable naming
/// contract required before broader light/dark theme work.
abstract final class ScavoColors {
  // Brand tokens.
  static const brandPrimary = Color(0xFF4F8CFF);
  static const brandPrimarySoft = Color(0xFF8AB3FF);
  static const brandAccent = Color(0xFF19E6A7);
  static const brandOnPrimary = Colors.white;

  // Background and surface tokens.
  static const backgroundPrimary = Color(0xFF0A0D14);
  static const backgroundSecondary = Color(0xFF121826);
  static const backgroundCanvas = backgroundPrimary;
  static const backgroundLayer = backgroundSecondary;
  static const surfacePrimary = Color(0xFF131B2E);
  static const surfaceSecondary = Color(0xFF182033);
  static const surfaceBase = surfacePrimary;
  static const surfaceRaised = surfaceSecondary;

  // Text tokens.
  static const textPrimary = Color(0xFFF5F7FB);
  static const textSecondary = Color(0xFF9EABC7);
  static const textMuted = Color(0xFF6B7895);
  static const textDisabled = textMuted;
  static const textOnAction = brandOnPrimary;

  // Boundary tokens.
  static const borderDefault = Color(0xFF26314D);
  static const borderSubtle = Color(0xFF1D2740);
  static const dividerDefault = Color(0xFF26314D);
  static const dividerSubtle = borderSubtle;

  // Semantic state tokens.
  static const semanticDanger = Color(0xFFFF5D73);
  static const semanticWarning = Color(0xFFFFC857);
  static const semanticSuccess = Color(0xFF1EDC8B);
  static const semanticInfo = brandPrimary;

  // Interaction tokens.
  static const actionPrimary = brandPrimary;
  static const actionSecondary = brandAccent;
  static const actionDanger = semanticDanger;
  static const actionDisabled = textMuted;
  static const focus = brandPrimary;
  static const focusRing = focus;

  // Overlay tokens.
  static const overlayScrim = Color(0x73000000);
  static const transparent = Colors.transparent;
}
