import 'package:scavium_wallet/app/theme/tokens/scavo_colors.dart';

/// Backwards-compatible color facade for the SCAVIUM theme layer.
///
/// New theme work should prefer the semantic token names exposed by
/// [ScavoColors]. These aliases keep the existing app stable while Phase 9.3
/// migrates consumers incrementally.
abstract final class AppColors {
  static const background = ScavoColors.backgroundPrimary;
  static const surface = ScavoColors.backgroundSecondary;
  static const surfaceSoft = ScavoColors.surfaceSecondary;
  static const card = ScavoColors.surfacePrimary;
  static const canvas = ScavoColors.backgroundCanvas;
  static const layer = ScavoColors.backgroundLayer;

  static const primary = ScavoColors.brandPrimary;
  static const primarySoft = ScavoColors.brandPrimarySoft;
  static const accent = ScavoColors.brandAccent;
  static const onPrimary = ScavoColors.brandOnPrimary;

  static const textPrimary = ScavoColors.textPrimary;
  static const textSecondary = ScavoColors.textSecondary;
  static const textMuted = ScavoColors.textMuted;
  static const textDisabled = ScavoColors.textDisabled;

  static const border = ScavoColors.borderDefault;
  static const borderSubtle = ScavoColors.borderSubtle;
  static const divider = ScavoColors.dividerDefault;
  static const danger = ScavoColors.semanticDanger;
  static const warning = ScavoColors.semanticWarning;
  static const success = ScavoColors.semanticSuccess;
  static const info = ScavoColors.semanticInfo;
}
