import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_colors.dart';

/// Theme-specific color sets built from the SCAVIUM semantic token contract.
class ScavoThemeColors {
  final Brightness brightness;
  final Color canvas;
  final Color layer;
  final Color surfaceBase;
  final Color surfaceRaised;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color iconActive;
  final Color iconInactive;
  final Color iconMuted;
  final Color iconOnAction;
  final Color actionPrimary;
  final Color actionSecondary;
  final Color actionDisabled;
  final Color textOnAction;
  final Color danger;
  final Color warning;
  final Color success;
  final Color info;
  final Color focusRing;

  const ScavoThemeColors({
    required this.brightness,
    required this.canvas,
    required this.layer,
    required this.surfaceBase,
    required this.surfaceRaised,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.iconActive,
    required this.iconInactive,
    required this.iconMuted,
    required this.iconOnAction,
    required this.actionPrimary,
    required this.actionSecondary,
    required this.actionDisabled,
    required this.textOnAction,
    required this.danger,
    required this.warning,
    required this.success,
    required this.info,
    required this.focusRing,
  });

  static const dark = ScavoThemeColors(
    brightness: Brightness.dark,
    canvas: ScavoColors.backgroundCanvas,
    layer: ScavoColors.backgroundLayer,
    surfaceBase: ScavoColors.surfaceBase,
    surfaceRaised: ScavoColors.surfaceRaised,
    border: ScavoColors.borderDefault,
    divider: ScavoColors.dividerDefault,
    textPrimary: ScavoColors.textPrimary,
    textSecondary: ScavoColors.textSecondary,
    textDisabled: ScavoColors.textDisabled,
    iconActive: ScavoColors.actionPrimary,
    iconInactive: ScavoColors.textSecondary,
    iconMuted: ScavoColors.textMuted,
    iconOnAction: ScavoColors.textOnAction,
    actionPrimary: ScavoColors.actionPrimary,
    actionSecondary: ScavoColors.actionSecondary,
    actionDisabled: ScavoColors.actionDisabled,
    textOnAction: ScavoColors.textOnAction,
    danger: ScavoColors.semanticDanger,
    warning: ScavoColors.semanticWarning,
    success: ScavoColors.semanticSuccess,
    info: ScavoColors.semanticInfo,
    focusRing: ScavoColors.focusRing,
  );

  static const light = ScavoThemeColors(
    brightness: Brightness.light,
    canvas: Color(0xFFF8FAFC),
    layer: Color(0xFFF1F5F9),
    surfaceBase: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFF1F5F9),
    border: Color(0xFFE2E8F0),
    divider: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0A0D14),
    textSecondary: Color(0xFF44516D),
    textDisabled: Color(0xFF8792A8),
    iconActive: ScavoColors.brandPrimary,
    iconInactive: Color(0xFF526079),
    iconMuted: Color(0xFF6B7895),
    iconOnAction: ScavoColors.brandOnPrimary,
    actionPrimary: ScavoColors.brandPrimary,
    actionSecondary: ScavoColors.brandSupport,
    actionDisabled: Color(0xFFCBD5E1),
    textOnAction: ScavoColors.brandOnPrimary,
    danger: ScavoColors.semanticDanger,
    warning: ScavoColors.semanticWarning,
    success: ScavoColors.semanticSuccess,
    info: ScavoColors.brandSupport,
    focusRing: ScavoColors.brandPrimary,
  );
}
