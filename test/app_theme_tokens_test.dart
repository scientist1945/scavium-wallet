import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavium_wallet/app/theme/app_colors.dart';
import 'package:scavium_wallet/app/theme/app_text_styles.dart';
import 'package:scavium_wallet/app/theme/app_theme.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  group('SCAVIUM theme token contract', () {
    test('preserves legacy color facade mappings', () {
      expect(AppColors.background, ScavoColors.backgroundPrimary);
      expect(AppColors.surface, ScavoColors.backgroundSecondary);
      expect(AppColors.surfaceSoft, ScavoColors.surfaceSecondary);
      expect(AppColors.card, ScavoColors.surfacePrimary);
      expect(AppColors.primary, ScavoColors.brandPrimary);
      expect(AppColors.accent, ScavoColors.brandAccent);
      expect(AppColors.border, ScavoColors.borderDefault);
      expect(AppColors.danger, ScavoColors.semanticDanger);
      expect(AppColors.warning, ScavoColors.semanticWarning);
      expect(AppColors.success, ScavoColors.semanticSuccess);
    });

    test('keeps expanded color intents mapped to centralized tokens', () {
      expect(ScavoColors.backgroundCanvas, ScavoColors.backgroundPrimary);
      expect(ScavoColors.backgroundLayer, ScavoColors.backgroundSecondary);
      expect(ScavoColors.surfaceBase, ScavoColors.surfacePrimary);
      expect(ScavoColors.surfaceRaised, ScavoColors.surfaceSecondary);
      expect(ScavoColors.textDisabled, ScavoColors.textMuted);
      expect(ScavoColors.dividerSubtle, ScavoColors.borderSubtle);
      expect(ScavoColors.semanticInfo, ScavoColors.brandPrimary);
      expect(ScavoColors.focusRing, ScavoColors.focus);
      expect(AppColors.canvas, ScavoColors.backgroundCanvas);
      expect(AppColors.info, ScavoColors.semanticInfo);
    });

    test('keeps compact non-component token scales', () {
      expect(ScavoSpacing.none, 0);
      expect(ScavoSpacing.xs < ScavoSpacing.sm, isTrue);
      expect(ScavoSpacing.sm < ScavoSpacing.md, isTrue);
      expect(ScavoSpacing.md < ScavoSpacing.lg, isTrue);
      expect(ScavoSpacing.compact, ScavoSpacing.xs);
      expect(ScavoSpacing.standard, ScavoSpacing.md);
      expect(ScavoSpacing.comfortable, ScavoSpacing.lg);
      expect(ScavoSpacing.section, ScavoSpacing.xxl);
      expect(ScavoRadius.none, 0);
      expect(ScavoRadius.xs < ScavoRadius.sm, isTrue);
      expect(ScavoRadius.sm < ScavoRadius.md, isTrue);
      expect(ScavoRadius.md < ScavoRadius.lg, isTrue);
      expect(ScavoRadius.interactive, ScavoRadius.md);
      expect(ScavoRadius.container, ScavoRadius.lg);
      expect(ScavoRadius.overlay, ScavoRadius.xl);
      expect(ScavoElevation.none, 0);
      expect(ScavoElevation.surface, ScavoElevation.none);
      expect(ScavoElevation.interactive, ScavoElevation.none);
      expect(ScavoElevation.floating, ScavoElevation.raised);
      expect(ScavoElevation.modal, ScavoElevation.overlay);
    });

    test('preserves legacy typography facade mappings', () {
      expect(AppTextStyles.display.fontSize, ScavoTypography.display.fontSize);
      expect(AppTextStyles.h1.fontSize, ScavoTypography.title.fontSize);
      expect(AppTextStyles.h2.fontSize, ScavoTypography.subtitle.fontSize);
      expect(AppTextStyles.body.fontSize, ScavoTypography.body.fontSize);
      expect(AppTextStyles.bodyMuted.color, ScavoTypography.bodyMuted.color);
      expect(AppTextStyles.button.color, ScavoTypography.button.color);
      expect(
        AppTextStyles.headline.fontSize,
        ScavoTypography.headline.fontSize,
      );
      expect(
        AppTextStyles.actionLabel.color,
        ScavoTypography.actionLabel.color,
      );
    });

    test('builds dark theme from normalized token values', () {
      final theme = AppTheme.darkTheme;

      expect(theme.scaffoldBackgroundColor, ScavoColors.backgroundCanvas);
      expect(theme.colorScheme.primary, ScavoColors.actionPrimary);
      expect(theme.colorScheme.surface, ScavoColors.backgroundLayer);
      expect(theme.colorScheme.error, ScavoColors.semanticDanger);
      expect(theme.cardTheme.color, ScavoColors.surfaceBase);
      expect(theme.cardTheme.elevation, ScavoElevation.surface);
      expect(theme.inputDecorationTheme.fillColor, ScavoColors.surfaceRaised);
      expect(theme.snackBarTheme.backgroundColor, ScavoColors.surfaceRaised);
      expect(theme.dialogTheme.backgroundColor, ScavoColors.surfaceBase);
    });
  });
}
