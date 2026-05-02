import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/app/theme/app_colors.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

void main() {
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

    test('keeps compact non-component token scales', () {
      expect(ScavoSpacing.xs < ScavoSpacing.sm, isTrue);
      expect(ScavoSpacing.sm < ScavoSpacing.md, isTrue);
      expect(ScavoSpacing.md < ScavoSpacing.lg, isTrue);
      expect(ScavoRadius.sm < ScavoRadius.md, isTrue);
      expect(ScavoRadius.md < ScavoRadius.lg, isTrue);
      expect(ScavoElevation.none, 0);
    });
  });
}
