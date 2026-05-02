import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_colors.dart';

/// Typography tokens for the SCAVIUM visual system.
abstract final class ScavoTypography {
  static TextStyle get display => GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: ScavoColors.textPrimary,
    height: 1.1,
  );

  static TextStyle get title => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get subtitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: ScavoColors.textPrimary,
  );

  static TextStyle get bodyMuted => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ScavoColors.textSecondary,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: ScavoColors.textSecondary,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: ScavoColors.textOnAction,
  );
}
