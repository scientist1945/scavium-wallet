import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme => _buildTheme(ScavoThemeColors.dark);

  static ThemeData get lightTheme => _buildTheme(ScavoThemeColors.light);

  static ThemeData _buildTheme(ScavoThemeColors colors) {
    final isDark = colors.brightness == Brightness.dark;
    final base =
        isDark
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true);

    final textTheme = _textTheme(colors);

    return base.copyWith(
      brightness: colors.brightness,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme(
        brightness: colors.brightness,
        primary: colors.actionPrimary,
        onPrimary: colors.textOnAction,
        secondary: colors.actionSecondary,
        onSecondary: colors.textOnAction,
        error: colors.danger,
        onError: colors.textOnAction,
        surface: colors.layer,
        onSurface: colors.textPrimary,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: ScavoColors.transparent,
        elevation: ScavoElevation.surface,
        surfaceTintColor: ScavoColors.transparent,
        centerTitle: false,
        foregroundColor: colors.textPrimary,
        titleTextStyle: textTheme.headlineMedium,
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceBase,
        elevation: ScavoElevation.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.container),
          side: BorderSide(color: colors.border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: ScavoSpacing.standard,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.actionPrimary,
          foregroundColor: colors.textOnAction,
          disabledBackgroundColor: colors.actionDisabled,
          disabledForegroundColor: colors.textSecondary,
          elevation: ScavoElevation.interactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.actionPrimary,
          foregroundColor: colors.textOnAction,
          disabledBackgroundColor: colors.actionDisabled,
          disabledForegroundColor: colors.textSecondary,
          elevation: ScavoElevation.interactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.actionPrimary,
          disabledForegroundColor: colors.textDisabled,
          side: BorderSide(color: colors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.actionPrimary,
          disabledForegroundColor: colors.textDisabled,
          textStyle: textTheme.labelMedium,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceRaised,
        selectedColor: colors.actionPrimary,
        disabledColor: colors.actionDisabled,
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.textOnAction,
        ),
        side: BorderSide(color: colors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.pill),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? colors.actionPrimary
                : colors.surfaceBase;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? colors.textOnAction
                : colors.textSecondary;
          }),
          iconColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? colors.textOnAction
                : colors.textSecondary;
          }),
          side: WidgetStatePropertyAll(BorderSide(color: colors.border)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScavoRadius.interactive),
            ),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelMedium),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surfaceBase,
        indicatorColor: colors.surfaceRaised,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color =
              states.contains(WidgetState.selected)
                  ? colors.actionPrimary
                  : colors.textSecondary;

          return textTheme.labelMedium?.copyWith(color: color);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final color =
              states.contains(WidgetState.selected)
                  ? colors.actionPrimary
                  : colors.textSecondary;

          return IconThemeData(color: color);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surfaceBase,
        selectedIconTheme: IconThemeData(color: colors.actionPrimary),
        unselectedIconTheme: IconThemeData(color: colors.textSecondary),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colors.actionPrimary,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium,
        indicatorColor: colors.surfaceRaised,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceRaised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.focusRing),
        ),
        labelStyle: textTheme.labelMedium,
        hintStyle: textTheme.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceRaised,
        contentTextStyle: textTheme.bodyLarge,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.sm),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceBase,
        elevation: ScavoElevation.modal,
        titleTextStyle: textTheme.headlineMedium,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.overlay),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.focusRing,
        selectionColor: colors.actionPrimary.withValues(alpha: 0.28),
        selectionHandleColor: colors.actionPrimary,
      ),
    );
  }

  static TextTheme _textTheme(ScavoThemeColors colors) {
    return TextTheme(
      displayLarge: ScavoTypography.display.copyWith(color: colors.textPrimary),
      headlineLarge: ScavoTypography.title.copyWith(color: colors.textPrimary),
      headlineMedium: ScavoTypography.subtitle.copyWith(
        color: colors.textPrimary,
      ),
      bodyLarge: ScavoTypography.body.copyWith(color: colors.textPrimary),
      bodyMedium: ScavoTypography.bodySecondary.copyWith(
        color: colors.textSecondary,
      ),
      labelMedium: ScavoTypography.label.copyWith(color: colors.textSecondary),
      labelLarge: ScavoTypography.actionLabel.copyWith(
        color: colors.textOnAction,
      ),
    );
  }
}
