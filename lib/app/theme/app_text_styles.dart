import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_typography.dart';

/// Backwards-compatible typography facade for existing widgets.
///
/// New theme work should prefer [ScavoTypography] directly so typography and
/// text-color intent remain part of the token contract.
abstract final class AppTextStyles {
  static TextStyle get display => ScavoTypography.display;
  static TextStyle get h1 => ScavoTypography.title;
  static TextStyle get h2 => ScavoTypography.subtitle;
  static TextStyle get body => ScavoTypography.body;
  static TextStyle get bodyMuted => ScavoTypography.bodyMuted;
  static TextStyle get label => ScavoTypography.label;
  static TextStyle get button => ScavoTypography.button;
}
