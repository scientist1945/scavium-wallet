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
        onPrimary: ScavoColors.textOnAction,
        onSurface: ScavoColors.textPrimary,
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
      dividerTheme: const DividerThemeData(
        color: ScavoColors.dividerDefault,
        thickness: 1,
        space: ScavoSpacing.standard,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ScavoColors.actionPrimary,
          foregroundColor: ScavoColors.textOnAction,
          disabledBackgroundColor: ScavoColors.actionDisabled,
          disabledForegroundColor: ScavoColors.textSecondary,
          elevation: ScavoElevation.interactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          ),
          textStyle: ScavoTypography.actionLabel,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ScavoColors.textOnAction,
          disabledForegroundColor: ScavoColors.textDisabled,
          side: const BorderSide(color: ScavoColors.borderDefault),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          ),
          textStyle: ScavoTypography.actionLabel,
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
        labelStyle: ScavoTypography.label,
        hintStyle: ScavoTypography.bodySecondary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ScavoColors.surfaceRaised,
        contentTextStyle: ScavoTypography.body,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.sm),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ScavoColors.surfaceBase,
        elevation: ScavoElevation.modal,
        titleTextStyle: ScavoTypography.subhead,
        contentTextStyle: ScavoTypography.bodySecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.overlay),
        ),
      ),
    );
  }
}
