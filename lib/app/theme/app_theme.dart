import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: ScavoColors.backgroundPrimary,
      colorScheme: const ColorScheme.dark(
        primary: ScavoColors.actionPrimary,
        secondary: ScavoColors.actionSecondary,
        surface: ScavoColors.backgroundSecondary,
        error: ScavoColors.semanticDanger,
      ),
      textTheme: TextTheme(
        displayLarge: ScavoTypography.display,
        headlineLarge: ScavoTypography.title,
        headlineMedium: ScavoTypography.subtitle,
        bodyLarge: ScavoTypography.body,
        bodyMedium: ScavoTypography.bodyMuted,
        labelLarge: ScavoTypography.button,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ScavoColors.transparent,
        elevation: ScavoElevation.none,
        surfaceTintColor: ScavoColors.transparent,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: ScavoColors.surfacePrimary,
        elevation: ScavoElevation.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.lg),
          side: const BorderSide(color: ScavoColors.borderDefault),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ScavoColors.surfaceSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.md),
          borderSide: const BorderSide(color: ScavoColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.md),
          borderSide: const BorderSide(color: ScavoColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.md),
          borderSide: const BorderSide(color: ScavoColors.focus),
        ),
      ),
    );
  }
}
