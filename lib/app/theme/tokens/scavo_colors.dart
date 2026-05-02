import 'package:flutter/material.dart';

/// Semantic color tokens for the SCAVIUM visual system.
///
/// Tokens describe UI intent instead of raw color names. The current values
/// preserve the established dark SCAVIUM identity and provide the stable naming
/// contract required before broader light/dark theme work.
abstract final class ScavoColors {
  // Brand tokens.
  static const brandPrimary = Color(0xFFF97316);
  static const brandPrimarySoft = Color(0xFFFDBA74);
  static const brandAccent = Color(0xFF2563EB);
  static const brandSupport = brandAccent;
  static const brandOnPrimary = Colors.white;

  // Background and surface tokens.
  static const backgroundPrimary = Color(0xFF0B1220);
  static const backgroundSecondary = Color(0xFF0F1A2E);
  static const backgroundCanvas = backgroundPrimary;
  static const backgroundLayer = backgroundSecondary;
  static const surfacePrimary = Color(0xFF0F1A2E);
  static const surfaceSecondary = Color(0xFF13213A);
  static const surfaceBase = surfacePrimary;
  static const surfaceRaised = surfaceSecondary;

  // Text tokens.
  static const textPrimary = Color(0xFFF5F7FB);
  static const textSecondary = Color(0xFF9EABC7);
  static const textMuted = Color(0xFF6B7895);
  static const textDisabled = textMuted;
  static const textOnAction = brandOnPrimary;

  // Boundary tokens.
  static const borderDefault = Color(0xFF1F2A44);
  static const borderSubtle = Color(0xFF17213A);
  static const dividerDefault = Color(0xFF1F2A44);
  static const dividerSubtle = borderSubtle;

  // Semantic state tokens.
  static const semanticDanger = Color(0xFFEF4444);
  static const semanticWarning = Color(0xFFF59E0B);
  static const semanticSuccess = Color(0xFF22C55E);
  static const semanticInfo = brandSupport;

  // Interaction tokens.
  static const actionPrimary = brandPrimary;
  static const actionSecondary = brandSupport;
  static const actionDanger = semanticDanger;
  static const actionDisabled = textMuted;
  static const focus = brandPrimary;
  static const focusRing = focus;

  // Overlay tokens.
  static const overlayScrim = Color(0x73000000);
  static const transparent = Colors.transparent;
}
