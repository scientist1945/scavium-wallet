import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: ScavoColors.backgroundCanvas,
      colorScheme: const ColorScheme.dark(
        primary: ScavoColors.actionPrimary,
        secondary: ScavoColors.actionSecondary,
        surface: ScavoColors.backgroundLayer,
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
        elevation: ScavoElevation.surface,
        surfaceTintColor: ScavoColors.transparent,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: ScavoColors.surfaceBase,
        elevation: ScavoElevation.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.container),
          side: const BorderSide(color: ScavoColors.borderDefault),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ScavoColors.surfaceRaised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: const BorderSide(color: ScavoColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: const BorderSide(color: ScavoColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: const BorderSide(color: ScavoColors.focusRing),
        ),
      ),
    );
  }
}
