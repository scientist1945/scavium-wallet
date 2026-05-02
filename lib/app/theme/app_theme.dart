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
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(ScavoRadius.interactive),
      borderSide: BorderSide(color: colors.border),
    );

    return base.copyWith(
      brightness: colors.brightness,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: base.colorScheme.copyWith(
        brightness: colors.brightness,
        primary: colors.actionPrimary,
        onPrimary: colors.textOnAction,
        secondary: colors.actionSecondary,
        onSecondary: colors.textOnAction,
        tertiary: colors.success,
        onTertiary: colors.textOnAction,
        error: colors.danger,
        onError: colors.textOnAction,
        surface: colors.layer,
        onSurface: colors.textPrimary,
        onSurfaceVariant: colors.textSecondary,
        outline: colors.border,
        outlineVariant: colors.divider,
      ),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: colors.iconInactive),
      primaryIconTheme: IconThemeData(color: colors.iconActive),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colors.textDisabled;
            }
            if (states.contains(WidgetState.selected)) {
              return colors.iconActive;
            }
            return colors.iconInactive;
          }),
        ),
      ),
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
        elevation: isDark ? ScavoElevation.surface : ScavoElevation.raised,
        shadowColor: Colors.black.withValues(alpha: isDark ? 0.18 : 0.08),
        surfaceTintColor: ScavoColors.transparent,
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
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.disabled)
                ? colors.textDisabled
                : colors.actionPrimary;
          }),
          iconColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.disabled)
                ? colors.textDisabled
                : colors.actionPrimary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            final color =
                states.contains(WidgetState.disabled)
                    ? colors.actionDisabled
                    : colors.border;
            return BorderSide(color: color);
          }),
          overlayColor: WidgetStatePropertyAll(
            colors.actionPrimary.withValues(alpha: 0.08),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScavoRadius.interactive),
            ),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
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
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colors.textSecondary,
        ),
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
        indicatorColor: colors.actionPrimary.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color =
              states.contains(WidgetState.selected)
                  ? colors.iconActive
                  : colors.iconInactive;

          return textTheme.labelMedium?.copyWith(color: color);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final color =
              states.contains(WidgetState.selected)
                  ? colors.iconActive
                  : colors.iconInactive;

          return IconThemeData(color: color);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surfaceBase,
        selectedIconTheme: IconThemeData(color: colors.iconActive),
        unselectedIconTheme: IconThemeData(color: colors.iconInactive),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colors.iconActive,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colors.iconInactive,
        ),
        indicatorColor: colors.actionPrimary.withValues(alpha: 0.16),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.iconInactive,
        textColor: colors.textPrimary,
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodyMedium,
        selectedColor: colors.iconActive,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceRaised,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.focusRing, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          borderSide: BorderSide(color: colors.danger, width: 1.4),
        ),
        labelStyle: textTheme.labelMedium,
        floatingLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.actionPrimary,
        ),
        hintStyle: textTheme.bodyMedium,
        errorStyle: textTheme.bodyMedium?.copyWith(color: colors.danger),
        prefixIconColor: colors.iconMuted,
        suffixIconColor: colors.iconMuted,
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
      bodySmall: ScavoTypography.bodyMuted.copyWith(color: colors.textSecondary),
      titleLarge: ScavoTypography.title.copyWith(color: colors.textPrimary),
      titleMedium: ScavoTypography.subtitle.copyWith(color: colors.textPrimary),
      titleSmall: ScavoTypography.label.copyWith(color: colors.textPrimary),
      labelMedium: ScavoTypography.label.copyWith(color: colors.textSecondary),
      labelLarge: ScavoTypography.actionLabel.copyWith(
        color: colors.textOnAction,
      ),
    );
  }
}
