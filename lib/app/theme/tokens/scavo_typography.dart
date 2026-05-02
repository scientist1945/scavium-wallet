import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_colors.dart';

/// Typography tokens for the SCAVIUM visual system.
abstract final class ScavoTypography {
  static const fontFamily = 'Inter';

  static TextStyle get display => _inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: ScavoColors.textPrimary,
    height: 1.1,
  );

  static TextStyle get title => _inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get subtitle => _inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get body => _inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get bodyMuted => _inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ScavoColors.textSecondary,
  );

  static TextStyle get label => _inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: ScavoColors.textSecondary,
  );

  static TextStyle get button => _inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textOnAction,
  );

  static TextStyle get headline => title;
  static TextStyle get subhead => subtitle;
  static TextStyle get bodySecondary => bodyMuted;
  static TextStyle get actionLabel => button;

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    if (!GoogleFonts.config.allowRuntimeFetching) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    }

    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}
